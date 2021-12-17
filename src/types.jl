struct ModuleState
    mod::Module
end

mutable struct InterpState
    debug::Bool
    depth::Int
    maxdepth::Int
    mods::Vector{ModuleState}
end

mutable struct CodeState
    interpstate::InterpState
    src::Core.CodeInfo
    names::Vector{Symbol}
    lenv::Core.SimpleVector
    pc::Int
    ssavalues::Vector
    slots::Vector
    handlers::Vector{Int}
    exceptions::Vector{Exception}
end

function code_state_from_thunk(interpstate, src)
    CodeState(interpstate, src, [], Core.svec(), 1,
        Vector(undef, length(src.code)), 
        Vector(undef, length(src.slotnames)),
        Int[],
        Exception[])
end

internal_typeof(x::Type) = Type{x}
internal_typeof(x) = typeof(x)

function code_state_from_call(codestate, fun, parms...)
    meth = which(fun, internal_typeof.(parms))
    src = Base.uncompressed_ast(meth)
    names = Base.method_argnames(meth)
    sig = Base.signature_type(fun, internal_typeof.(parms))
    (ti, lenv) = ccall(:jl_type_intersection_with_env, Any, (Any, Any), sig, meth.sig)
    codestate = CodeState(codestate.interpstate, src, names, lenv, 1,
        Vector(undef, length(src.code)), 
        Vector(undef, length(src.slotnames)),
        Int[],
        Exception[])
    codestate.slots[1] = fun
    if !meth.isva
        for idx in 2:min(meth.nargs, length(parms) + 1) 
            codestate.slots[idx] = parms[idx - 1]
        end
    else
        for idx in 2:min(meth.nargs, length(parms) + 1) - 1
            codestate.slots[idx] = parms[idx - 1]
        end
        codestate.slots[meth.nargs] = parms[meth.nargs - 1:end]
    end
    codestate
end

function run_code_state(codestate)
    while true
        codestate.interpstate.debug && @show codestate.pc codestate.src.code[codestate.pc]
        ans = interprete_lower(codestate, codestate.src.code[codestate.pc])
        if ans isa Some
            codestate.interpstate.debug && @show ans
            return ans.value
        end
    end
end
