quote_all(val) = QuoteNode(val)

function lookup_lower_boundscheck(codestate::CodeState, args)
    # @show :boundscheck args
    true
end
function lookup_lower_loopinfo(codestate::CodeState, args)
    # @show :loopinfo args
    nothing
end
function lookup_lower_inbounds(codestate::CodeState, args)
    # @show :inbounds args
    args[1]
end
function lookup_lower_meta(codestate::CodeState, args)
    # @show :meta args
    args[1]
end

function lookup_lower_gc_preserve_begin(codestate::CodeState, args)
    # @show :gc_preserve_begin args
    nothing
end
function lookup_lower_gc_preserve_end(codestate::CodeState, args)
    # @show :gc_preserve_end args
    nothing
end

function isdefined_lower_static_parameter(codestate::CodeState, args)
    isassigned(codestate.sparam_vals, args[1]::Int)
end
function lookup_lower_static_parameter(codestate::CodeState, args)
    @assert isassigned(codestate.sparam_vals, args[1]::Int)
    codestate.sparam_vals[args[1]::Int]
end

function isdefined_lower_the_exception(codestate::CodeState, args)
    !isempty(codestate.interpstate.exceptions)
end
function lookup_lower_the_exception(codestate::CodeState, args)
    @assert !isempty(codestate.interpstate.exceptions)
    last(codestate.interpstate.exceptions).exception
end

function lookup_lower_isdefined(codestate::CodeState, args)
    isdefined_lower(codestate, args[1])
end

function lookup_lower_new(codestate::CodeState, args)
    # @show :new args
    type = quote_all(lookup_lower(codestate, args[1]))
    # @show type typeof(type)
    parms = Any[quote_all(lookup_lower(codestate, arg)) for arg in @view args[2:end]]
    # @show parms
    # ccall(:jl_new_structv, Any, (Any, Ptr{Any}, UInt), type, parms, length(parms))
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:new, type, parms...))
end
function lookup_lower_new_opaque_closure(codestate::CodeState, args)
    @show :new_opaque_closure args
    type = quote_all(lookup_lower(codestate, args[1]))
    @show type typeof(type)
    parms = Any[quote_all(lookup_lower(codestate, arg)) for arg in @view args[2:end]]
    @show parms
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:new_opaque_closure, type, parms...))
end
function lookup_lower_splatnew(codestate::CodeState, args)
    # @show :splatnew args
    type = quote_all(lookup_lower(codestate, args[1]))
    # @show type typeof(type)
    # parms = ((lookup_lower(codestate, arg) for arg in @view args[2:end])...,)
    parms = Any[quote_all(lookup_lower(codestate, arg)) for arg in @view args[2:end]]
    # @show parms
    # ccall(:jl_new_structt, Any, (Any, Any), type, parms[1])
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:splatnew, type, parms...))
end

function rootmodule(mod::Module)
    ans = mod
    parent = parentmodule(mod)
    while parent != mod
        ans = mod
        mod = parent
        parent = parentmodule(mod)
    end
    ans
end
function rootmodule(callable)
    parent = parentmodule(callable)
    rootmodule(parent)
end
function clear_child_state(codestate::CodeState, callable)
    codestate.childstates[codestate.pc][codestate.cc] =
        callable, nothing
end
function set_child_state(codestate::CodeState, callable, parms)
    if !isassigned(codestate.childstates[codestate.pc], codestate.cc)
        wt = world_type(callable, parms)
        childstate = code_state_from_call(codestate, wt)
        codestate.childstates[codestate.pc][codestate.cc] = callable, childstate
        childstate
    else
        prev_callable, prev_childstate = codestate.childstates[codestate.pc][codestate.cc]
        if prev_childstate isa CodeState
            wt = world_type(callable, parms)
            if wt != prev_childstate.wt
                childstate = code_state_from_call(codestate, wt)
                codestate.childstates[codestate.pc][codestate.cc] = callable, childstate
                childstate
            else
                prev_childstate
            end
        else
            wt = world_type(callable, parms)
            childstate = code_state_from_call(codestate, wt)
            codestate.childstates[codestate.pc][codestate.cc] = callable, childstate
            childstate
        end
    end
end
function to_intercept(codestate::CodeState, callable)
    if haskey(codestate.interpstate.intercepts, callable)
        clear_child_state(codestate, callable)
        codestate.interpstate.intercepts[callable]
    else
        nothing
    end
end
function to_interpret(codestate::CodeState, callable, parms)
    root = rootmodule(callable)
    if root in codestate.interpstate.options.modules
        childstate = set_child_state(codestate, callable, parms)
        if childstate isa CodeState
            update_code_state(childstate, callable, parms)
            return childstate
        end
    elseif root in codestate.interpstate.options.limiteds && check_code_statistics(codestate)
        childstate = set_child_state(codestate, callable, parms)
        if childstate isa CodeState
            if check_interp_statistics(codestate.interpstate, childstate.mod_or_meth)
                update_code_state(childstate, callable, parms)
                return childstate
            end
        end
    end
    return nothing
end
function lookup_lower_call(codestate::CodeState, callable, parms)
    if (ans = to_intercept(codestate, callable)) !== nothing
        intercept = ans::Base.Callable
        return intercept(codestate, parms)
    elseif callable isa Core.Builtin || callable isa Core.IntrinsicFunction
        clear_child_state(codestate, callable)
    elseif (ans = to_interpret(codestate, callable, parms)) !== nothing
        childstate = ans::CodeState
        return interpret_lower(childstate)
    else
        clear_child_state(codestate, callable)
    end
    # eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
    #   Expr(:call, fun, parms...))
    if codestate.mod_or_meth isa Module
        return Base.invokelatest(callable, parms...)
    else
        # fun(parms...)
        # Base.invoke_in_world(codestate.wc, fun, parms...)
        return Base.invokelatest(callable, parms...)
    end
end
function lookup_lower_call(codestate::CodeState, args)
    # @nospecialize args
    # @show :call args
    fun = lookup_lower(codestate, args[1])
    # @show fun typeof(fun)
    # parms = ((lookup_lower(codestate, arg) for arg in @view args[2:end])...,)
    parms = Any[lookup_lower(codestate, arg) for arg in @view args[2:end]]
    # @show parms
    if fun isa Base.Callable
        callable = fun
        lookup_lower_call(codestate, callable, parms)
    else
        # @show fun typeof(fun)
        Base.invokelatest(fun, parms...)
    end            
end

function lookup_lower_cfunction(codestate::CodeState, args)
    # @nospecialize args
    # @show :cfunction args
    type = lookup_lower(codestate, args[1])
    # @show type typeof(type)
    if codestate.mod_or_meth isa Method && !isempty(codestate.sparam_vals)
        rt = ccall(:jl_instantiate_type_in_env, Any, (Any, Any, Ptr{Any}),
            args[3], codestate.mod_or_meth.sig, codestate.sparam_vals)
        at = Core.svec((
            ccall(:jl_instantiate_type_in_env, Any, (Any, Any, Ptr{Any}),
                arg, codestate.mod_or_meth.sig, codestate.sparam_vals) for arg in args[4])...)
    else
        rt = args[3]
        at = args[4]
    end
    cc = args[5]
    # @show rt at cc
    parm = quote_all(lookup_lower(codestate, args[2]))
    # @show parm
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:cfunction, type, parm, rt, at, cc))
end
function lookup_lower_foreigncall(codestate::CodeState, args)
    # @nospecialize args
    # @show :foreigncall args
    fun = quote_all(lookup_lower(codestate, args[1]))
    # @show fun typeof(fun)
    if codestate.mod_or_meth isa Method && !isempty(codestate.sparam_vals)
        rt = ccall(:jl_instantiate_type_in_env, Any, (Any, Any, Ptr{Any}),
            args[2], codestate.mod_or_meth.sig, codestate.sparam_vals)
        at = Core.svec((
            ccall(:jl_instantiate_type_in_env, Any, (Any, Any, Ptr{Any}),
                arg, codestate.mod_or_meth.sig, codestate.sparam_vals) for arg in args[3])...)
    else
        rt = args[2]
        at = args[3]
    end
    reshape
    nreq = args[4]
    cc = args[5]
    # @show rt at nreq cc
    # parms = ((lookup_lower(codestate, arg) for arg in args[6:end]))...,)
    parms = Any[quote_all(lookup_lower(codestate, arg)) for arg in args[6:end]]
    # @show parms
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:foreigncall, fun, rt, at, nreq, cc, parms...))
end
function lookup_lower_method(codestate::CodeState, args)
    # @show :method args
    meth = args[1]
    # @show meth typeof(meth)
    # parms = ((lookup_lower(codestate, arg) for arg in @view args[2:end])...,)
    parms = Any[lookup_lower(codestate, arg) for arg in @view args[2:end]]
    # @show parms
    if length(parms) >= 2
        # branching on https://github.com/JuliaLang/julia/pull/41137
        @static if isdefined(Core.Compiler, :OverlayMethodTable)
            ccall(:jl_method_def, Cvoid, (Any, Ptr{Cvoid}, Any, Any),
                parms[1], C_NULL, parms[2], moduleof(codestate.mod_or_meth))
        else
            ccall(:jl_method_def, Cvoid, (Any, Any, Any),
                parms[1], parms[2], moduleof(codestate.mod_or_meth))
        end
    end
    if isdefined_lower(codestate, meth)
        lookup_lower(codestate, meth)
    else
        eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
            Expr(:function, meth))
    end
end
function lookup_lower_copyast(codestate::CodeState, args)
    val = lookup_lower(codestate, args[1])
    if val isa Expr
        expr = val
        copy(expr)
    else
        val
    end
end

function lookup_lower_enter(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_enter args
    push!(codestate.handlers, args[1]::Int)
    length(codestate.interpstate.exceptions)
end
function lookup_lower_pop_exception(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_pop_exception args
    deleteat!(codestate.interpstate.exceptions,
        lookup_lower(codestate, args[1])::Int + 1:length(codestate.interpstate.exceptions))
end
function lookup_lower_leave(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_leave args
    len = length(codestate.handlers)
    deleteat!(codestate.handlers, len - args[1]::Int + 1:len)
end

function lookup_lower_assign(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_assign args
    val = lookup_lower(codestate, args[2])
    assign_lower(codestate, args[1], val)
end

function lookup_lower_const(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_const args
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:const, args...))
end
function lookup_lower_global(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_global args
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:global, args...))
end
function lookup_lower_using(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_using args
    eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        Expr(:using, args...))
end

function lookup_lower_thunk(codestate::CodeState, args)
    codestate.interpstate.options.debug && @show :lookup_lower_thunk args
    mod = moduleof(codestate.mod_or_meth)
    codestate = code_state_from_thunk(codestate.interpstate, mod, args[1]::Core.CodeInfo)
    interpret_lower(codestate)
end

function isdefined_lower_expr(codestate::CodeState, expr::Expr)
    #= if expr.head == :boundscheck
        isdefined_lower_boundscheck(codestate, expr.args)
    elseif expr.head == :loopinfo
        isdefined_lower_loopinfo(codestate, expr.args)
    elseif expr.head == :inbounds
        isdefined_lower_inbounds(codestate, expr.args)
    elseif expr.head == :meta
        isdefined_lower_meta(codestate, expr.args)
    elseif expr.head == :gc_preserve_begin
        isdefined_lower_gc_preserve_begin(codestate, expr.args)
    elseif expr.head == :gc_preserve_end
        isdefined_lower_gc_preserve_end(codestate, expr.args)
    else =#
    if expr.head == :static_parameter
        isdefined_lower_static_parameter(codestate, expr.args)
    elseif expr.head == :the_exception
        isdefined_lower_the_exception(codestate, expr.args)
    #= elseif expr.head == :isdefined
        isdefined_lower_isdefined(codestate, expr.args)
    elseif expr.head == :new
        isdefined_lower_new(codestate, expr.args)
    elseif expr.head == :new_opaque_closure
        isdefined_lower_new_opaque_closure(codestate, expr.args)
    elseif expr.head == :splatnew
        isdefined_lower_splatnew(codestate, expr.args)
    elseif expr.head == :call
        isdefined_lower_call(codestate, expr.args)
    elseif expr.head == :cfunction
        isdefined_lower_cfunction(codestate, expr.args)
    elseif expr.head == :foreigncall
        isdefined_lower_foreigncall(codestate, expr.args)
    elseif expr.head == :method
        isdefined_lower_method(codestate, expr.args)
    elseif expr.head == :copyast
        isdefined_lower_copyast(codestate, expr.args) =#
    else
        @show expr.head expr.args
        @assert false
    end
end

function lookup_lower_expr(codestate::CodeState, expr::Expr)
    if expr.head == :boundscheck
        lookup_lower_boundscheck(codestate, expr.args)
    elseif expr.head == :loopinfo
        lookup_lower_loopinfo(codestate, expr.args)
    elseif expr.head == :inbounds
        lookup_lower_inbounds(codestate, expr.args)
    elseif expr.head == :meta
        lookup_lower_meta(codestate, expr.args)
    elseif expr.head == :gc_preserve_begin
        lookup_lower_gc_preserve_begin(codestate, expr.args)
    elseif expr.head == :gc_preserve_end
        lookup_lower_gc_preserve_end(codestate, expr.args)
    elseif expr.head == :static_parameter
        lookup_lower_static_parameter(codestate, expr.args)
    elseif expr.head == :the_exception
        lookup_lower_the_exception(codestate, expr.args)
    elseif expr.head == :isdefined
        lookup_lower_isdefined(codestate, expr.args)
    elseif expr.head == :new
        lookup_lower_new(codestate, expr.args)
    elseif expr.head == :new_opaque_closure
        lookup_lower_new_opaque_closure(codestate, expr.args)
    elseif expr.head == :splatnew
        lookup_lower_splatnew(codestate, expr.args)
    elseif expr.head == :call
        lookup_lower_call(codestate, expr.args)
    elseif expr.head == :cfunction
        lookup_lower_cfunction(codestate, expr.args)
    elseif expr.head == :foreigncall
        lookup_lower_foreigncall(codestate, expr.args)
    elseif expr.head == :method
        lookup_lower_method(codestate, expr.args)
    elseif expr.head == :copyast
        lookup_lower_copyast(codestate, expr.args)
    elseif expr.head == :enter
        lookup_lower_enter(codestate, expr.args)
    elseif expr.head == :pop_exception
        lookup_lower_pop_exception(codestate, expr.args)
    elseif expr.head == :leave
        lookup_lower_leave(codestate, expr.args)
    elseif expr.head == :(=)
        lookup_lower_assign(codestate, expr.args)
    elseif expr.head == :const
        lookup_lower_const(codestate, expr.args)
    elseif expr.head == :global
        lookup_lower_global(codestate, expr.args)
    elseif expr.head == :using
        lookup_lower_using(codestate, expr.args)
    elseif expr.head == :thunk
        lookup_lower_thunk(codestate, expr.args)
    else
        @show expr.head expr.args
        @assert false
    end
end

function isdefined_lower(codestate::CodeState, var)
    @nospecialize var
    # @show :isdefined_lower typeof(var) var
    if var isa Core.SSAValue
        ssavalue = var
        isassigned(codestate.ssavalues, ssavalue.id)
    elseif var isa Core.SlotNumber
        slotnumber = var
        isassigned(codestate.slots, slotnumber.id)
    elseif var isa Core.NewvarNode
        newvarnode = var
        isassigned(codestate.slots, newvarnode.slot.id)
    elseif var isa Symbol
        symbol = var
        isdefined(moduleof(codestate.mod_or_meth), symbol)
    elseif var isa GlobalRef
        globalref = var
        isdefined(globalref.mod, globalref.name)
    elseif var isa QuoteNode
        quotenode = var
        true
    elseif var isa Expr
        expr = var
        isdefined_lower_expr(codestate, expr)
    else
        true
    end
end

function lookup_lower(codestate::CodeState, var)
    @nospecialize var
    # @show :lookup_lower typeof(var) var
    if var isa Core.SSAValue
        ssavalue = var
        @assert isassigned(codestate.ssavalues, ssavalue.id)
        codestate.ssavalues[ssavalue.id]
    elseif var isa Core.SlotNumber
        slotnumber = var
        @assert isassigned(codestate.slots, slotnumber.id)
        codestate.slots[slotnumber.id]
    elseif var isa Core.NewvarNode
        newvarnode = var
        @assert isassigned(codestate.slots, newvarnode.slot.id)
        codestate.slots[newvarnode.slot.id]
    elseif var isa Symbol
        symbol = var
        getfield(moduleof(codestate.mod_or_meth), symbol)
    elseif var isa GlobalRef
        globalref = var
        getfield(globalref.mod, globalref.name)
    elseif var isa QuoteNode
        quotenode = var
        quotenode.value
    elseif var isa Expr
        expr = var
        val = lookup_lower_expr(codestate, expr)
        codestate.cc += 1
        if codestate.cc > length(codestate.childstates[codestate.pc])
            resize!(codestate.childstates[codestate.pc], codestate.cc)
        end
        val
    else
        # @show typeof(var) var
        var
    end
end

function assign_lower(codestate::CodeState, var, val)
    @nospecialize var val
    if var isa Core.SSAValue
        ssavalue = var
        codestate.ssavalues[ssavalue.id] = val
    elseif var isa Core.SlotNumber
        slotnumber = var
        codestate.slots[slotnumber.id] = val
    elseif var isa Core.NewvarNode
        newvarnode = var
        codestate.slots[newvarnode.slot.id] = val
    elseif var isa Symbol
        symbol = var
        eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
            Expr(:(=), symbol, quote_all(val)))
    elseif var isa GlobalRef
        globalref = var
        eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
            Expr(:(=), globalref, quote_all(val)))
    else
        @show :assign_lower typeof(var) var val
        @assert false
    end
end

function prepare_calls(codestate)
    codestate.cc = 1
    if !isassigned(codestate.childstates, codestate.pc)
        codestate.childstates[codestate.pc] = Vector{ChildState}(undef, codestate.cc)
    end
end

function interpret_lower_node(codestate::CodeState, node)
    @nospecialize node
    codestate.interpstate.options.debug && @show :interpret_lower codestate.pc codestate.src.code[codestate.pc]
    time = time_ns()
    try
        if node isa Core.NewvarNode
            newvarnode = node
            # @assert !isassigned(codestate.slots, newvarnode.slot.id)
            codestate.pc += 1
        elseif node isa Core.ReturnNode
            returnnode = node
            prepare_calls(codestate)
            return lookup_lower(codestate, returnnode.val)
        elseif node isa Core.GotoIfNot
            gotoifnot = node
            prepare_calls(codestate)
            if lookup_lower(codestate, gotoifnot.cond)
                codestate.pc += 1
            else
                codestate.pc = gotoifnot.dest
            end
        elseif node isa Core.GotoNode
            gotonode = node
            codestate.pc = gotonode.label
        else
            prepare_calls(codestate)
            val = lookup_lower(codestate, node)
            assign_lower(codestate, Core.SSAValue(codestate.pc), val)
            codestate.pc += 1
        end
    catch
        exceptions = Compat.current_exceptions()
        codestate.interpstate.options.debug && @show :interpret_lower last(exceptions)
        append!(codestate.interpstate.exceptions, exceptions)
        if isempty(codestate.handlers)
            rethrow(pop!(codestate.interpstate.exceptions).exception)
        else
            codestate.pc = last(codestate.handlers)
        end
    finally
        update_code_statistics(codestate, time_ns() - time)
    end
end

function interpret_lower(codestate::CodeState)
    codestate.interpstate.options.debug && @show :interpret_lower codestate.pc codestate.src
    time = time_ns()
    try
        while true
            node = codestate.src.code[codestate.pc]
            ans = interpret_lower_node(codestate, node)
            if node isa Core.ReturnNode
                return ans
            end
        end
    finally
        update_interp_statistics(codestate.interpstate, codestate.mod_or_meth, time_ns() - time)
    end
end
