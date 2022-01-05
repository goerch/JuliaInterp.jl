function isdefined_lower_expr(codestate, val, args)
    @show val args
    @assert false
end
function lookup_lower_expr(codestate, val, args)
    @show val args
    @assert false
end

function lookup_lower_expr(codestate, ::Val{:boundscheck}, args)
    # @show :boundscheck args
    true
end
function lookup_lower_expr(codestate, ::Val{:loopinfo}, args)
    # @show :loopinfo args
    nothing
end
function lookup_lower_expr(codestate, ::Val{:inbounds}, args)
    # @show :inbounds args
    args[1]
end
function lookup_lower_expr(codestate, ::Val{:meta}, args)
    # @show :meta args
    args[1]
end

function lookup_lower_expr(codestate, ::Val{:gc_preserve_begin}, args)
    # @show :gc_preserve_begin args
    nothing
end
function lookup_lower_expr(codestate, ::Val{:gc_preserve_end}, args)
    # @show :gc_preserve_end args
    nothing
end

function isdefined_lower_expr(codestate, ::Val{:static_parameter}, args)
    isassigned(codestate.lenv, args[1])
end
function lookup_lower_expr(codestate, ::Val{:static_parameter}, args)
    @assert isassigned(codestate.lenv, args[1])
    codestate.lenv[args[1]]
end

function isdefined_lower_expr(codestate, ::Val{:the_exception}, args)
    !isempty(codestate.interpstate.exceptions)
end
function lookup_lower_expr(codestate, ::Val{:the_exception}, args)
    @assert !isempty(codestate.interpstate.exceptions)
    last(codestate.interpstate.exceptions).exception
end

function lookup_lower_expr(codestate, ::Val{:isdefined}, args)
    isdefined_lower(codestate, args[1])
end

function lookup_lower_expr(codestate, ::Val{:new}, args)
    # @show :new args
    type = lookup_lower(codestate, args[1])
    # @show type
    parms = Any[lookup_lower(codestate, arg) for arg in @view args[2:end]]
    # @show parms
    # eval_ast(codestate.interpstate, Expr(:new, type, parms...))
    ccall(:jl_new_structv, Any, (Any, Ptr{Any}, UInt64), type, parms, length(parms))
end
function lookup_lower_expr(codestate, ::Val{:new_opaque_closure}, args)
    @show :new_opaque_closure args
    nothing
end
function lookup_lower_expr(codestate, ::Val{:splatnew}, args)
    # @show :splatnew args
    type = lookup_lower(codestate, args[1])
    # @show type
    parms = ((lookup_lower(codestate, arg) for arg in @view args[2:end])...,)
    # @show parms
    # eval_ast(codestate.interpstate, Expr(:splatnew, type, parms[1]))
    ccall(:jl_new_structt, Any, (Any, Any), type, parms[1])
end
function lookup_lower_expr(codestate, ::Val{:call}, args)
    # @show :call args
    fun = lookup_lower(codestate, args[1])
    # @show fun
    parms = ((lookup_lower(codestate, arg) for arg in @view args[2:end])...,)
    # @show parms
    if fun isa Base.Callable
        id = (parentmodule(fun), nameof(fun))
        intercept = get(codestate.interpstate.intercepts, id, fun)
        if intercept != fun
            return intercept(codestate, parms)
        elseif id in codestate.interpstate.passthroughs
            # 
        elseif !(fun isa Core.Builtin) && !(fun isa Core.IntrinsicFunction) 
            if !isassigned(codestate.times, codestate.pc) || codestate.times[codestate.pc] < codestate.interpstate.budget
                childstate = code_state_from_call(codestate, fun, parms)
                if childstate !== nothing
                    # childstate.interpstate.debug = true
                    try
                        childstate.interpstate.debug && @show childstate.src
                        return run_code_state(childstate)
                    finally
                        # childstate.interpstate.debug = false
                    end
                else
                    codestate.times[codestate.pc] = codestate.interpstate.budget
                end
            end
        end
    end
    # eval_ast(codestate.interpstate, Expr(:call, fun, parms...))
    Base.invokelatest(fun, parms...)
end
function lookup_lower_expr(codestate, ::Val{:foreigncall}, args)
    # @show :foreigncall args
    fun = QuoteNode(lookup_lower(codestate, args[1]))
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
    parms = ((QuoteNode(lookup_lower(codestate, arg)) for arg in args[6:end])...,)
    # @show parms
    eval_ast(codestate.interpstate, Expr(:foreigncall, fun, rt, at, nreq, cc, parms...))
end
function lookup_lower_expr(codestate, ::Val{:method}, args)
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
    isdefined_lower_expr(codestate, Val(expr.head), expr.args)
end
function lookup_lower(codestate, expr::Expr)
    lookup_lower_expr(codestate, Val(expr.head), expr.args)
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

function handle_times(codestate, start, stop)
    if !isassigned(codestate.times, codestate.pc)
        codestate.times[codestate.pc] = stop - start
    else
        codestate.times[codestate.pc] += stop - start
    end
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

function interpret_lower_expr(codestate, val::Val{T}, args) where T
    if !(T in [:boundscheck, 
               :call, :foreigncall, 
               :gc_preserve_begin, :gc_preserve_end, 
               :inbounds, :isdefined, :loopinfo, :meta, 
               :new, :new_opaque_closure, :splatnew, 
               :static_parameter, :the_exception])
        @show :interpret_lower_expr T args
        @assert false
    end
    codestate.interpstate.debug && @show :interpret_lower_expr T args
    lookup_lower_expr(codestate, val, args)
end

function interpret_lower_expr(codestate, ::Val{:enter}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :enter args
    push!(codestate.handlers, args[1])
    length(codestate.interpstate.exceptions)
end
function interpret_lower_expr(codestate, ::Val{:pop_exception}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :pop_exception args
    deleteat!(codestate.interpstate.exceptions,
        lookup_lower(codestate, args[1]) + 1:length(codestate.interpstate.exceptions))
end
function interpret_lower_expr(codestate, ::Val{:leave}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :leave args
    len = length(codestate.handlers)
    deleteat!(codestate.handlers, len - args[1] + 1:len)
end

function interpret_lower_expr(codestate, ::Val{:(=)}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :(=) args
    assign_lower(codestate, args[1], lookup_lower(codestate, args[2]))
end

function interpret_lower_expr(codestate, ::Val{:method}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :method args
    meth = args[1]
    parms = ((lookup_lower(codestate, arg) for arg in @view args[2:end])...,)
    if length(parms) >= 2
        # branching on https://github.com/JuliaLang/julia/pull/41137
        @static if isdefined(Core.Compiler, :OverlayMethodTable)
            ccall(:jl_method_def, Cvoid, (Any, Ptr{Cvoid}, Any, Any),
                parms[1], C_NULL, parms[2], last(codestate.interpstate.mods).mod)
        else
            ccall(:jl_method_def, Cvoid, (Any, Any, Any),
                parms[1], parms[2], last(codestate.interpstate.mods).mod)
        end
    end
    if isdefined_lower(codestate, meth)
        return lookup_lower(codestate, meth)
    else
        eval_ast(codestate.interpstate, Expr(:function, meth))
    end
end
function interpret_lower_expr(codestate, ::Val{:cfunction}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :cfunction args
    eval_ast(codestate.interpstate, Expr(:cfunction, args...))
end
function interpret_lower_expr(codestate, ::Val{:const}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :const args
    eval_ast(codestate.interpstate, Expr(:const, args...))
end
function interpret_lower_expr(codestate, ::Val{:global}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :global args
    eval_ast(codestate.interpstate, Expr(:global, args...))
end
function interpret_lower_expr(codestate, ::Val{:using}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :using args
    eval_ast(codestate.interpstate, Expr(:using, args...))
end

function interpret_lower_expr(codestate, ::Val{:thunk}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :thunk args
    interpret_lower(codestate.interpstate, codestate, args[1])
end

copy_lower(expr::Expr) = copy(expr)
copy_lower(val) = val
function interpret_lower_expr(codestate, ::Val{:copyast}, args)
    codestate.interpstate.debug && @show :interpret_lower_expr :copyast args
    copy_lower(lookup_lower(codestate, args[1]))
end

function interpret_lower_node(codestate, node)
    codestate.interpstate.debug && @show :interpret_lower_node typeof(node) node
    try
        time = time_ns()
        try
            assign_lower(codestate, Core.SSAValue(codestate.pc),
                lookup_lower(codestate, node))
        finally
            handle_times(codestate, time, time_ns())
        end
        codestate.pc += 1
    catch
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower_node(codestate, newvarnode::Core.NewvarNode)
    codestate.interpstate.debug && @show :interpret_lower_node newvarnode
    try
        codestate.pc += 1
    catch
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower_node(codestate, returnnode::Core.ReturnNode)
    codestate.interpstate.debug && @show :interpret_lower_node returnnode
    try
        time = time_ns()
        try
            ans = lookup_lower(codestate, returnnode.val)
            return Some{typeof(ans)}(ans)
        finally
            handle_times(codestate, time, time_ns())
        end
    catch
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end
function interpret_lower_node(codestate, gotoifnot::Core.GotoIfNot)
    codestate.interpstate.debug && @show :interpret_lower_node gotoifnot
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
function interpret_lower_node(codestate, gotonode::Core.GotoNode)
    codestate.interpstate.debug && @show :interpret_lower_node gotonode
    try
        codestate.pc = gotonode.label
    catch
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower_node(codestate, expr::Expr)
    codestate.interpstate.debug && @show :interpret_lower_node expr
    try
        time = time_ns()
        try
            assign_lower(codestate, Core.SSAValue(codestate.pc),
                interpret_lower_expr(codestate, Val(expr.head), expr.args))
        finally
            handle_times(codestate, time, time_ns())
        end
        codestate.pc += 1
    catch
        handle_error(codestate, Compat.current_exceptions())
    end
    return nothing
end

function interpret_lower(interpstate, parent, src)
    codestate = code_state_from_thunk(interpstate, src)
    # interpstate.debug = true
    try
        codestate.interpstate.debug && @show :interpret_lower codestate.pc codestate.src
        return run_code_state(codestate)
    finally
        # interpstate.debug = false
    end
end
