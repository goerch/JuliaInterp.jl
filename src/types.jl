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
    src::Core.CodeInfo
    meth::Union{Method, Module}
    names::Vector{Symbol}
    lenv::Core.SimpleVector
    pc::Int
    ssavalues::Vector
    times::Vector{UInt64}
    slots::Vector
    handlers::Vector{Int}
end

function code_state_from_thunk(interpstate, src)
    CodeState(interpstate, src, last(interpstate.mods).mod, [], Core.svec(), 1,
        Vector(undef, length(src.code)), 
        Vector{UInt64}(undef, length(src.code)), 
        Vector(undef, length(src.slotnames)),
        Int[])
end

internal_typeof(x::Type) = Type{x}
internal_typeof(x) = typeof(x)

function code_state_from_call(codestate, fun, parms...)
    meth = which(fun, internal_typeof.(parms))
    src = Base.uncompressed_ast(meth)
    # src = Base.uncompressed_ir(meth)
    names = Base.method_argnames(meth)
    sig = Base.signature_type(fun, internal_typeof.(parms))
    (ti, lenv) = ccall(:jl_type_intersection_with_env, Any, (Any, Any), sig, meth.sig)
    codestate = CodeState(codestate.interpstate, src, meth, names, lenv, 1,
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
    codestate
end

function run_code_state(codestate)
    while true
        codestate.interpstate.debug && @show codestate.pc codestate.src.code[codestate.pc]
        ans = interpret_lower(codestate, codestate.src.code[codestate.pc])
        if ans isa Some
            codestate.interpstate.debug && @show ans
            return ans.value
        end
    end
end
