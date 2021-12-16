function lookup_lower(codestate, val, args) 
    return nothing
end

function lookup_lower(codestate, ::Val{:boundscheck}, args)     
    true
end
function lookup_lower(codestate, ::Val{:static_parameter}, args)    
    codestate.lenv[args[1]]
end

function lookup_lower(codestate, ::Val{:the_exception}, args)     
    last(codestate.exceptions)
end

function lookup_lower(codestate, ::Val{:isdefined}, args) 
    isdefined(last(codestate.interpstate.mods).mod, args[1])
end
function lookup_lower(codestate, ::Val{:new}, args)     
    # @show args
    type = lookup_lower(codestate, args[1])
    # @show type
    parms = [lookup_lower(codestate, arg) for arg in args[2:end]]
    # @show parms
    # ccall(:jl_new_structv, Any, (Any, Ptr{Any}, UInt32), type, parms, length(parms))
    eval_ast(codestate.interpstate, Expr(:new, type, parms...))
end
function lookup_lower(codestate, ::Val{:call}, args) 
    # @show args
    fun = lookup_lower(codestate, args[1])
    # @show fun
    parms = [lookup_lower(codestate, arg) for arg in args[2:end]]
    # @show parms
    if codestate.interpstate.depth < codestate.interpstate.maxdepth &&
        !(fun isa Core.IntrinsicFunction) && !(fun isa Core.Builtin) && !(parentmodule(fun) in [Core, Base])
        # codestate.interpstate.debug = true
        codestate.interpstate.depth += 1
        try
            local childstate
            try
                childstate = code_state_from_call(codestate, fun, parms...)
            catch 
                childstate = nothing
            end
            if childstate isa CodeState
                return run_code_state(childstate)
            end
        finally
            codestate.interpstate.depth -= 1
            # codestate.interpstate.debug = false
        end
    end
    # eval_ast_lower(codestate.interpstate, Expr(:call, fun, parms...))
    try
        return fun(parms...)
    catch exception
        if exception isa ErrorException || exception isa MethodError 
            return Base.@invokelatest fun(parms...)
        else
            rethrow(exception)
        end
    end
    # Base.@invokelatest fun(parms...)
end
function lookup_lower(codestate, ::Val{:foreigncall}, args) 
    # @show args
    fun = lookup_lower(codestate, args[1])
    # @show fun
    parms = [lookup_lower(codestate, arg) for arg in args[6:end]]
    # @show parms
    # eval_ast(codestate.interpstate, Expr(:foreigncall, fun, args[2:5]..., parms...))
    eval(Expr(:foreigncall, fun, args[2:5]..., parms...))
    #= if fun isa Symbol
        eval(Expr(:foreigncall, (fun, "libjulia.dll"), args[2:5]..., parms...))
    else 
        eval(Expr(:foreigncall, fun, args[2:5]..., parms...))
    end =#
end
function lookup_lower(codestate, ::Val{:method}, args) 
    args[1]
end

function lookup_lower(codestate, var)
    var
end
function lookup_lower(codestate, ssavalue::Core.SSAValue)
    codestate.ssavalues[ssavalue.id]
end
function lookup_lower(codestate, slotnumber::Core.SlotNumber)
    codestate.slots[slotnumber.id]
end
function lookup_lower(codestate, symbol::Symbol)
    getfield(last(codestate.interpstate.mods).mod, symbol)
end
function lookup_lower(codestate, globalref::GlobalRef)
    getfield(globalref.mod, globalref.name)
end
function lookup_lower(codestate, quotenode::QuoteNode)
    quotenode.value 
end
function lookup_lower(codestate, newvarnode::Core.NewvarNode)
    nothing
end
function lookup_lower(codestate, expr::Expr)
    lookup_lower(codestate, Val(expr.head), expr.args)
end

function assign_lower(codestate, var, val) 
    @show :assign_lower var val
    @assert false
end
function assign_lower(codestate, ssavalue::Core.SSAValue, val)
    codestate.ssavalues[ssavalue.id] = val
end
function assign_lower(codestate, slotnumber::Core.SlotNumber, val)
    codestate.slots[slotnumber.id] = val
end
function assign_lower(codestate, symbol::Symbol, val)
    eval_ast(codestate.interpstate, Expr(:(=), symbol, val))
end

function handle_error(codestate, exception)
    codestate.interpstate.debug && @show :handle_error exception 
    if isempty(codestate.handlers)
        rethrow(exception)
    else
        push!(codestate.exceptions, exception)
        codestate.pc = last(codestate.handlers)
    end
end

function interprete_lower(codestate, ::Val{T}, args) where T
    codestate.ssavalues[codestate.pc] = lookup_lower(codestate, Expr(T, args...))
    codestate.pc += 1
end

function interprete_lower(codestate, ::Val{:enter}, args)     
    codestate.interpstate.debug && @show :interprete_lower :enter args
    push!(codestate.handlers, args[1])
    codestate.pc += 1
end
function interprete_lower(codestate, ::Val{:leave}, args) 
    codestate.interpstate.debug && @show :interprete_lower :leave args
    pop!(codestate.handlers)
    codestate.pc += 1
end
function interprete_lower(codestate, ::Val{:pop_exception}, args)     
    codestate.interpstate.debug && @show :interprete_lower :pop_exception args
    assign_lower(codestate, args[1], pop!(codestate.exceptions))
    codestate.pc += 1
end

function interprete_lower(codestate, ::Val{:(=)}, args) 
    codestate.interpstate.debug && @show :interprete_lower :(=) args
    try
        assign_lower(codestate, args[1], lookup_lower(codestate, args[2]))
        codestate.pc += 1
    catch exception
        handle_error(codestate, exception)
    end
end
function interprete_lower(codestate, ::Val{:method}, args) 
    codestate.interpstate.debug && @show :interprete_lower :(method) args
    try
        if length(args) > 1
            # branching on https://github.com/JuliaLang/julia/pull/41137
            @static if isdefined(Core.Compiler, :OverlayMethodTable)
                codestate.ssavalues[codestate.pc] =  
                    ccall(:jl_method_def, Cvoid, (Any, Ptr{Cvoid}, Any, Any), 
                        lookup_lower(codestate, args[2]), C_NULL, 
                        args[3], last(codestate.interpstate.mods).mod)
            else
                codestate.ssavalues[codestate.pc] =  
                    ccall(:jl_method_def, Cvoid, (Any, Any, Any), 
                        lookup_lower(codestate, args[2]), 
                        args[3], last(codestate.interpstate.mods).mod)
            end
        end
        if args[1] isa Symbol
            codestate.ssavalues[codestate.pc] = 
                eval_ast(codestate.interpstate, Expr(:function, args[1]))
        else
            codestate.ssavalues[codestate.pc] = 
                lookup_lower(codestate, args[1])
        end 
        codestate.pc += 1
    catch exception
        handle_error(codestate, exception)
    end
end
function interprete_lower(codestate, ::Val{:const}, args) 
    codestate.interpstate.debug && @show :interprete_lower :const args
    codestate.ssavalues[codestate.pc] = 
        eval_ast_lower(codestate.interpstate, Expr(:const, args...))
    codestate.pc += 1
end
function interprete_lower(codestate, ::Val{:global}, args) 
    codestate.interpstate.debug && @show :interprete_lower :global args
    codestate.ssavalues[codestate.pc] = 
        eval_ast_lower(codestate.interpstate, Expr(:global, args...))
    codestate.pc += 1
end
function interprete_lower(codestate, ::Val{:using}, args) 
    codestate.interpstate.debug && @show :interprete_lower :using args
    codestate.ssavalues[codestate.pc] = 
        eval_ast_lower(codestate.interpstate, Expr(:using, args...))
    codestate.pc += 1
end

function interprete_lower(codestate, ::Val{:thunk}, args) 
    codestate.interpstate.debug && @show :interprete_lower :thunk args
    # This works on 1.7.0
    #= codestate.ssavalues[codestate.pc] = 
        eval_ast(codestate.interpstate, Expr(:thunk, args...)) =#
    # This works on 1.8.0 only...
    codestate.ssavalues[codestate.pc] = 
        interprete_lower(codestate.interpstate, codestate, args[1])
    codestate.pc += 1
end 

function interprete_lower(codestate, ::Val{:copyast}, args)     
    codestate.interpstate.debug && @show :interprete_lower :enter args
    codestate.ssavalues[codestate.pc] = lookup_lower(codestate, args[1])
    codestate.pc += 1
end 

function interprete_lower(codestate, node) 
    codestate.interpstate.debug && @show :interprete_lower typeof(node) node
    try
        codestate.ssavalues[codestate.pc] = lookup_lower(codestate, node)
        codestate.pc += 1
    catch exception
        handle_error(codestate, exception)
    end
end

function interprete_lower(codestate, returnnode::Core.ReturnNode)
    codestate.interpstate.debug && @show :interprete_lower returnnode
    try
        return Some(lookup_lower(codestate, returnnode.val))
    catch exception
        handle_error(codestate, exception)
    end
    return nothing
end
function interprete_lower(codestate, gotoifnot::Core.GotoIfNot)
    codestate.interpstate.debug && @show :interprete_lower gotoifnot
    if lookup_lower(codestate, gotoifnot.cond)
        codestate.pc += 1
    else
        codestate.pc = gotoifnot.dest
    end
    return nothing
end
function interprete_lower(codestate, gotonode::Core.GotoNode)
    codestate.interpstate.debug && @show :interprete_lower gotonode
    codestate.pc = gotonode.label
    return nothing
end

function interprete_lower(codestate, expr::Expr) 
    codestate.interpstate.debug && @show :interprete_lower expr
    interprete_lower(codestate, Val(expr.head), expr.args)
    return nothing
end

function interprete_lower(interpstate, parent::Union{Nothing, CodeState}, src::Core.CodeInfo)
    # interpstate.debug = true
    interpstate.depth += 1
    try
        codestate = code_state_from_thunk(interpstate, src)
        codestate.interpstate.debug && @show codestate.src
        return run_code_state(codestate)
    finally
        interpstate.depth -= 1
        # interpstate.debug = false
    end
end
