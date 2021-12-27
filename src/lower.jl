function isdefined_lower(codestate, val, args)
    # @show val args
    true
end
function lookup_lower(codestate, val, args)
    # @show val args
    nothing
end

function isdefined_lower(codestate, ::Val{:boundscheck}, args)
    true
end
function lookup_lower(codestate, ::Val{:boundscheck}, args)
    true
end

function isdefined_lower(codestate, ::Val{:static_parameter}, args)
    isassigned(codestate.lenv, args[1])
end
function lookup_lower(codestate, ::Val{:static_parameter}, args)
    @assert isassigned(codestate.lenv, args[1])
    codestate.lenv[args[1]]
end

function isdefined_lower(codestate, ::Val{:the_exception}, args)
    !isempty(codestate.interpstate.exceptions)
end
function lookup_lower(codestate, ::Val{:the_exception}, args)
    @assert !isempty(codestate.interpstate.exceptions)
    last(codestate.interpstate.exceptions).exception
end

function lookup_lower(codestate, ::Val{:isdefined}, args)
    isdefined_lower(codestate, args[1])
end

function lookup_lower(codestate, ::Val{:new}, args)
    # @show args
    type = lookup_lower(codestate, args[1])
    # @show type
    parms = Any[lookup_lower(codestate, arg) for arg in @view args[2:end]]
    # @show parms
    # eval_ast(codestate.interpstate, Expr(:new, type, parms...))
    ccall(:jl_new_structv, Any, (Any, Ptr{Any}, UInt64), type, parms, length(parms))
end
@static if !isdefined(Base, :current_exceptions)
    current_exceptions = Base.catch_stack
else
    current_exceptions = Base.current_exceptions
end
exclude(fun) = !(fun isa Function) ||
    fun isa Core.IntrinsicFunction ||
    fun isa Core.Builtin ||
    Base.moduleroot(parentmodule(fun)) in [Core, Base]
function lookup_lower(codestate, ::Val{:call}, args)
    # @show :call args
    fun = lookup_lower(codestate, args[1])
    # @show fun
    parms = Any[lookup_lower(codestate, arg) for arg in @view args[2:end]]
    if fun == current_exceptions
        if isempty(parms) || parms[1] == current_task()
            return codestate.interpstate.exceptions
        end 
    elseif fun == Base.catch_backtrace
        if isempty(codestate.interpstate.exceptions)
            return []
        else
            return last(codestate.interpstate.exceptions).backtrace
        end
    elseif fun == Base.rethrow
        fun = Base.throw
        if isempty(parms) 
            if isempty(codestate.interpstate.exceptions)
                parms = [ErrorException("rethrow() not allowed outside a catch block")]
            else
                parms = [pop!(codestate.interpstate.exceptions).exception]
            end
        elseif isempty(codestate.interpstate.exceptions)
            parms = [ErrorException("rethrow(exc) not allowed outside a catch block")]
        end
    end
    # @show parms
    if !exclude(fun)
        if !isassigned(codestate.times, codestate.pc) || codestate.times[codestate.pc] < codestate.interpstate.budget
            local childstate
            try
                childstate = code_state_from_call(codestate, fun, parms...)
            catch
                childstate = nothing
            end
            if childstate isa CodeState
                # codestate.interpstate.debug = true
                time = time_ns()
                try
                    childstate.interpstate.debug && @show childstate.src
                    return run_code_state(childstate)
                finally
                    if !isassigned(codestate.times, codestate.pc)
                        codestate.times[codestate.pc] = time_ns() - time
                    else
                        codestate.times[codestate.pc] += time_ns() - time
                    end
                    # codestate.interpstate.debug = false
                end
            end
        elseif !exclude(fun)
            # @show :maybe_include codestate.interpstate.depth codestate.times[codestate.pc]
        end
    else
        # @show :exclude codestate.interpstate.depth
    end
    # eval_ast(codestate.interpstate, Expr(:call, fun, parms...))
    #= try
        return fun(parms...)
    catch exception
        if exception isa ErrorException || exception isa MethodError
            return Base.@invokelatest fun(parms...)
        else
            rethrow()
        end
    end =#
    if fun == Base.llvmcall
        funname = gensym("llvmcall")
        argnames = [Symbol(:(_), i) for i = 1:length(parms) - 3]
        ir = parms[1]
        rt = parms[2]
        at = parms[3]
        impl = quote
            function $funname($(argnames...))
                Base.llvmcall($ir, $rt, $at, $(argnames...))
            end
            $funname($(parms[4:end]...))
        end
        eval_ast(codestate.interpstate, impl)
    else
        Base.@invokelatest fun(parms...)
    end
end
function quote_lower(symbol::Symbol)
    QuoteNode(symbol)
end
function quote_lower(val)
    QuoteNode(val)
end
function lookup_lower(codestate, ::Val{:foreigncall}, args)
    # @show :foreigncall args
    fun = quote_lower(lookup_lower(codestate, args[1]))
    # @show fun
    if codestate.meth isa Method && !isempty(codestate.lenv) 
        rt = ccall(:jl_instantiate_type_in_env, Any, (Any, Any, Ptr{Any}), 
            args[2], codestate.meth.sig, codestate.lenv)
        at = Core.svec((
            ccall(:jl_instantiate_type_in_env, Any, (Any, Any, Ptr{Any}), 
                arg, codestate.meth.sig, codestate.lenv) for arg in args[3])...)
    else
        rt = args[2]
        at = args[3]
    end
    nreq = args[4]
    cc = args[5]
    # @show rt at nreq cc    
    parms = [quote_lower(lookup_lower(codestate, arg)) for arg in args[6:end]]
    # @show parms
    eval_ast(codestate.interpstate, Expr(:foreigncall, fun, rt, at, nreq, cc, parms...))
end
function lookup_lower(codestate, ::Val{:method}, args)
    args[1]
end

function isdefined_lower(codestate, var)
    # @show :isdefined_lower typeof(var) var
    true
end
function lookup_lower(codestate, var)
    # @show :lookup_lower typeof(var) var
    var
end
function isdefined_lower(codestate, ssavalue::Core.SSAValue)
    isassigned(codestate.ssavalues, ssavalue.id)
end
function lookup_lower(codestate, ssavalue::Core.SSAValue)
    @assert isassigned(codestate.ssavalues, ssavalue.id)
    codestate.ssavalues[ssavalue.id]
end
function isdefined_lower(codestate, slotnumber::Core.SlotNumber)
    isassigned(codestate.slots, slotnumber.id)
end
function lookup_lower(codestate, slotnumber::Core.SlotNumber)
    @assert isassigned(codestate.slots, slotnumber.id)
    codestate.slots[slotnumber.id]
end
function isdefined_lower(codestate, newvarnode::Core.NewvarNode)
    isassigned(codestate.slots, newvarnode.slot.id)
end
function lookup_lower(codestate, newvarnode::Core.NewvarNode)
    @assert isassigned(codestate.slots, newvarnode.slot.id)
    codestate.slots[newvarnode.slot.id]
end
function isdefined_lower(codestate, symbol::Symbol)
    isdefined(last(codestate.interpstate.mods).mod, symbol)
end
function lookup_lower(codestate, symbol::Symbol)
    getfield(last(codestate.interpstate.mods).mod, symbol)
end
function isdefined_lower(codestate, globalref::GlobalRef)
    isdefined(globalref.mod, globalref.name)
end
function lookup_lower(codestate, globalref::GlobalRef)
    getfield(globalref.mod, globalref.name)
end
function isdefined_lower(codestate, quotenode::QuoteNode)
    true
end
function lookup_lower(codestate, quotenode::QuoteNode)
    quotenode.value
end
function isdefined_lower(codestate, expr::Expr)
    isdefined_lower(codestate, Val(expr.head), expr.args)
end
function lookup_lower(codestate, expr::Expr)
    lookup_lower(codestate, Val(expr.head), expr.args)
end

function assign_lower(codestate, var, val)
    @show :assign_lower typeof(var) val
    @assert false
end
function assign_lower(codestate, ssavalue::Core.SSAValue, val)
    codestate.ssavalues[ssavalue.id] = val
end
function assign_lower(codestate, slotnumber::Core.SlotNumber, val)
    codestate.slots[slotnumber.id] = val
end
function assign_lower(codestate, newvarnode::Core.NewvarNode, val)
    codestate.slots[newvarnode.slot.id] = val
end
function assign_lower(codestate, symbol::Symbol, val)
    eval_ast(codestate.interpstate, Expr(:(=), symbol, QuoteNode(val)))
end
function assign_lower(codestate, globalref::GlobalRef, val)
    eval_ast(codestate.interpstate, Expr(:(=), globalref, QuoteNode(val)))
end

function handle_error(codestate, exceptions)
    codestate.interpstate.debug && @show :handle_error last(exceptions)
    append!(codestate.interpstate.exceptions, exceptions)
    if isempty(codestate.handlers)
        rethrow(pop!(codestate.interpstate.exceptions).exception)
    else
        codestate.pc = last(codestate.handlers)
    end
end

function interpret_lower(codestate, ::Val{T}, args) where T
    codestate.interpstate.debug && @show :interpret_lower T args
    codestate.ssavalues[codestate.pc] = lookup_lower(codestate, Expr(T, args...))
end

function interpret_lower(codestate, ::Val{:enter}, args)    
    codestate.interpstate.debug && @show :interpret_lower :enter args
    push!(codestate.handlers, args[1])
    codestate.ssavalues[codestate.pc] = length(codestate.interpstate.exceptions)
end
function interpret_lower(codestate, ::Val{:pop_exception}, args)
    codestate.interpstate.debug && @show :interpret_lower :pop_exception args
    deleteat!(codestate.interpstate.exceptions, 
        lookup_lower(codestate, args[1]) + 1:length(codestate.interpstate.exceptions))
end
function interpret_lower(codestate, ::Val{:leave}, args)
    codestate.interpstate.debug && @show :interpret_lower :leave args
    len = length(codestate.handlers)
    deleteat!(codestate.handlers, len - args[1] + 1:len)
end

function interpret_lower(codestate, ::Val{:(=)}, args)
    codestate.interpstate.debug && @show :interpret_lower :(=) args
    assign_lower(codestate, args[1], lookup_lower(codestate, args[2]))
end


function interpret_lower(codestate, ::Val{:method}, args)
    codestate.interpstate.debug && @show :interpret_lower :method args
    meth = args[1] 
    parms = Any[lookup_lower(codestate, arg) for arg in @view args[2:end]]
    if length(parms) > 0
        # branching on https://github.com/JuliaLang/julia/pull/41137
        @static if isdefined(Core.Compiler, :OverlayMethodTable)
            codestate.ssavalues[codestate.pc] =
                ccall(:jl_method_def, Cvoid, (Any, Ptr{Cvoid}, Any, Any),
                    parms[1], C_NULL, parms[2], last(codestate.interpstate.mods).mod)
        else
            codestate.ssavalues[codestate.pc] =
                ccall(:jl_method_def, Cvoid, (Any, Any, Any),
                    parms[1], parms[2], last(codestate.interpstate.mods).mod)
        end
    end
    if meth isa Symbol
        codestate.ssavalues[codestate.pc] =
            eval_ast(codestate.interpstate, Expr(:function, meth))
    else
        codestate.ssavalues[codestate.pc] =
            lookup_lower(codestate, meth)
    end
end
function interpret_lower(codestate, ::Val{:cfunction}, args)
    codestate.interpstate.debug && @show :interpret_lower :cfunction args
    codestate.ssavalues[codestate.pc] =
        eval_ast(codestate.interpstate, Expr(:cfunction, args...))
end
function interpret_lower(codestate, ::Val{:const}, args)
    codestate.interpstate.debug && @show :interpret_lower :const args
    codestate.ssavalues[codestate.pc] =
        eval_ast(codestate.interpstate, Expr(:const, args...))
end
function interpret_lower(codestate, ::Val{:global}, args)
    codestate.interpstate.debug && @show :interpret_lower :global args
    codestate.ssavalues[codestate.pc] =
        eval_ast(codestate.interpstate, Expr(:global, args...))
end
function interpret_lower(codestate, ::Val{:using}, args)
    codestate.interpstate.debug && @show :interpret_lower :using args
    codestate.ssavalues[codestate.pc] =
        eval_ast(codestate.interpstate, Expr(:using, args...))
end

function interpret_lower(codestate, ::Val{:thunk}, args)
    codestate.interpstate.debug && @show :interpret_lower :thunk args
    codestate.ssavalues[codestate.pc] =
        interpret_lower(codestate.interpstate, codestate, args[1])
end

function interpret_lower(codestate, ::Val{:copyast}, args)
    codestate.interpstate.debug && @show :interpret_lower :copyast args
    ans = lookup_lower(codestate, args[1])
    codestate.ssavalues[codestate.pc] = ans isa Expr ? copy(ans) : ans
end

function interpret_lower(codestate, node)
    codestate.interpstate.debug && @show :interpret_lower typeof(node) node
    try
        codestate.ssavalues[codestate.pc] = lookup_lower(codestate, node)
        codestate.pc += 1
    catch 
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower(codestate, newvarnode::Core.NewvarNode)
    codestate.interpstate.debug && @show :interpret_lower newvarnode
    try
        codestate.pc += 1
    catch 
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower(codestate, returnnode::Core.ReturnNode)
    codestate.interpstate.debug && @show :interpret_lower returnnode
    try
        ans = lookup_lower(codestate, returnnode.val)
        return Some{typeof(ans)}(ans)
    catch 
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end
function interpret_lower(codestate, gotoifnot::Core.GotoIfNot)
    codestate.interpstate.debug && @show :interpret_lower gotoifnot
    try
        if lookup_lower(codestate, gotoifnot.cond)
            codestate.pc += 1
        else
            codestate.pc = gotoifnot.dest
        end
    catch 
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end
function interpret_lower(codestate, gotonode::Core.GotoNode)
    codestate.interpstate.debug && @show :interpret_lower gotonode
    try
        codestate.pc = gotonode.label
    catch 
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower(codestate, expr::Expr)
    codestate.interpstate.debug && @show :interpret_lower expr
    try
        interpret_lower(codestate, Val(expr.head), expr.args)
        codestate.pc += 1
    catch 
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower(interpstate, parent::Union{Nothing, CodeState}, src::Core.CodeInfo)
    codestate = code_state_from_thunk(interpstate, src)
    # interpstate.debug = true
    try
        codestate.interpstate.debug && @show :interpret_lower codestate.src
        return run_code_state(codestate)
    finally
        # interpstate.debug = false
    end
end

