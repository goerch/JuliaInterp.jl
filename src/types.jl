struct ModuleState
    mod::Module
end

mutable struct InterpState
    debug::Bool
    budget::UInt64
    mods::Vector{ModuleState}
    exceptions::Vector
end

mutable struct CodeState
    interpstate::InterpState
    meth::Union{Method, Module}
    names::Vector{Symbol}
    lenv::Core.SimpleVector
    src::Core.CodeInfo
    pc::Int
    ssavalues::Vector
    times::Vector{UInt64}
    slots::Vector
    handlers::Vector{Int}
end

function code_state_from_thunk(interpstate, src)
    CodeState(interpstate, last(interpstate.mods).mod, [], Core.svec(), src, 1,
        Vector(undef, length(src.code)), 
        Vector{UInt64}(undef, length(src.code)), 
        Vector(undef, length(src.slotnames)),
        Int[])
end

typeof_lower(type::Type) = Type{type}
typeof_lower(val) = typeof(val)
generate_lower(codestate, expr::Expr) = eval_ast(codestate.interpstate, expr)
generate_lower(codestate, val) = val
function code_state_from_call(codestate, fun, parms)
    @assert !(fun isa Core.IntrinsicFunction) && !(fun isa Core.Builtin) 
    #= try
        meth = which(fun, typeof_lower.(parms...))
    catch exception
        if exception isa MethodError
            return nothing
        end
        rethrow(exception)
    end =#
    wc = ccall(:jl_get_world_counter, UInt, ())
    meth = ccall(:jl_gf_invoke_lookup, Any, (Any, UInt), typeof_lower.((fun, parms...)), wc)
    if meth === nothing
        return nothing
    end
    names = Base.method_argnames(meth)
    sig = Base.signature_type(fun, typeof_lower.(parms...))
    (ti, lenv) = ccall(:jl_type_intersection_with_env, Any, (Any, Any), sig, meth.sig)
    if !isdefined(meth, :generator)
        src = Base.uncompressed_ast(meth)
        # src = Base.uncompressed_ir(meth)
    else
        expr = Base.@invokelatest meth.generator(lenv..., meth.generator.argnames...)
        src = Meta.lower(last(codestate.interpstate.mods).mod, expr)
    end
    codestate = CodeState(codestate.interpstate, meth, names, lenv, src, 1,
        Vector(undef, length(src.code)), 
        Vector{UInt64}(undef, length(src.code)), 
        Vector(undef, length(src.slotnames)),
        Int[])
    codestate.slots[1] = fun
    if !meth.isva
        for idx in 2:meth.nargs 
            codestate.slots[idx] = parms[idx - 1]
        end
    else
        for idx in 2:meth.nargs - 1
            codestate.slots[idx] = parms[idx - 1]
        end
        codestate.slots[meth.nargs] = parms[meth.nargs - 1:end]
    end
    return codestate
end

function run_code_state(codestate)
    while true
        codestate.interpstate.debug && @show :run_code_state codestate.pc codestate.src.code[codestate.pc]
        ans = interpret_lower(codestate, codestate.src.code[codestate.pc])
        if ans isa Some
            codestate.interpstate.debug && @show :run_code_state ans
            return ans.value
        end
    end
end
