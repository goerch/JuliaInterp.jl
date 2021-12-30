@static if !isdefined(Base, :current_exceptions)
    current_exceptions = Base.catch_stack
else
    current_exceptions = Base.current_exceptions
end
function _current_exceptions(codestate, parms)
    if isempty(parms) || parms[1] == current_task()
        return codestate.interpstate.exceptions
    else
        return Compat.current_exceptions(parms...)
    end 
end
function _catch_backtrace(codestate, parms)
    if isempty(codestate.interpstate.exceptions)
        return []
    else
        return last(codestate.interpstate.exceptions).backtrace
    end
end
function _rethrow(codestate, parms)
    if isempty(parms) 
        if isempty(codestate.interpstate.exceptions)
            parms = (ErrorException("rethrow() not allowed outside a catch block"),)
        else
            parms = (pop!(codestate.interpstate.exceptions),)
        end
    elseif isempty(codestate.interpstate.exceptions)
        parms = (ErrorException("rethrow(exc) not allowed outside a catch block"),)
    end
    return Base.throw(parms...)
end
# https://github.com/JuliaLang/julia/issues/43556
function _iolock_begin(codestate, parms)
    # @show :iolock_begin codestate.interpstate.iolock codestate.src
    # if !codestate.interpstate.iolock 
    #     Base.iolock_begin(parms...)
    #     codestate.interpstate.iolock = true
    # end
    return nothing
end
function _iolock_end(codestate, parms)
    # @show :iolock_end codestate.interpstate.iolock codestate.src
    # if codestate.interpstate.iolock 
    #     codestate.interpstate.iolock = false
    #     Base.iolock_end(parms...)
    # end
    return nothing
end
function _sigatomic_begin(codestate, parms)
    # @show :sigatomic_begin codestate.interpstate.sigatomic codestate.src
    # if !codestate.interpstate.sigatomic 
        Base.sigatomic_begin(parms...)
        codestate.interpstate.sigatomic = true
    # end
    return nothing
end
function _sigatomic_end(codestate, parms)
    # @show :sigatomic_end codestate.interpstate.sigatomic codestate.src
    if codestate.interpstate.sigatomic 
        codestate.interpstate.sigatomic = false
        Base.sigatomic_end(parms...)
    end        
    return nothing
end
function _llvmcall(codestate, parms)
    @show :llvmcall codestate.src
    funname = gensym("llvmcall")
    argnames = ((Symbol(:(_), i) for i = 1:length(parms) - 3)...,)
    ir = parms[1]
    rt = parms[2]
    at = parms[3]
    impl = quote
        function $funname($(argnames...))
            Base.llvmcall($ir, $rt, $at, $(argnames...))
        end
        $funname($(parms[4:end]...))
    end
    return eval_ast(codestate.interpstate, impl)
end

struct ModuleState
    mod::Module
end

mutable struct InterpState
    intercepts::Dict{Function, Function}
    passthroughs::Set{Base.Callable}
    debug::Bool
    budget::UInt64
    mods::Vector{ModuleState}
    meths::Dict{Tuple{UInt, Any}, Tuple{Union{Method, Module}, Vector{Symbol}, Core.SimpleVector, Core.CodeInfo}}
    exceptions::Vector
    iolock::Bool
    sigatomic::Bool
end

function interp_state(debug, budget, mod)
    interpstate = InterpState(Dict(), Set(), debug, budget, [ModuleState(mod)], Dict(), [], false, false)
    interpstate.intercepts[current_exceptions] = _current_exceptions
    interpstate.intercepts[Base.catch_backtrace] = _catch_backtrace
    interpstate.intercepts[Base.rethrow] = _rethrow
    interpstate.intercepts[Base.iolock_begin] = _iolock_begin
    interpstate.intercepts[Base.iolock_end] = _iolock_end
    interpstate.intercepts[Base.sigatomic_begin] = _sigatomic_begin
    interpstate.intercepts[Base.sigatomic_end] = _sigatomic_end
    interpstate.intercepts[Base.llvmcall] = _llvmcall
    push!(interpstate.passthroughs, Base.lock)
    push!(interpstate.passthroughs, Base.unlock)
    for name in names(Base)
        fun = getfield(Base, name)
        if fun isa Base.Callable
            push!(interpstate.passthroughs, fun)
        end
    end
    for name in names(Core)
        fun = getfield(Core, name)
        if fun isa Base.Callable
            push!(interpstate.passthroughs, fun)
        end
    end
    interpstate
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
generate_lower(codestate, expr::Expr) = Meta.lower(last(codestate.interpstate.mods).mod, expr)
generate_lower(codestate, val) = val
function code_state_from_call(codestate, fun, parms)
    #= local meth
    try
        meth = which(fun, typeof_lower.(parms))
    catch exception
        if exception isa MethodError
            return nothing
        end
        rethrow(exception)
    end =# 
    wc = ccall(:jl_get_world_counter, UInt, ())
    tt = Tuple{typeof_lower.((fun, parms...))...}
    meth, names, lenv, src = get(codestate.interpstate.meths, (wc, tt), (nothing, nothing, nothing, nothing))
    if meth === nothing
        meth = ccall(:jl_gf_invoke_lookup, Any, (Any, UInt), tt, wc)
        if meth === nothing
            @show :code_state_from_call fun
            return nothing
        end 
        names = Base.method_argnames(meth)
        sig = Base.signature_type(fun, typeof_lower.(parms))
        (ti, lenv) = ccall(:jl_type_intersection_with_env, Any, (Any, Any), sig, meth.sig)
        if !isdefined(meth, :generator)
            src = Base.uncompressed_ast(meth)
            # src = Base.uncompressed_ir(meth)
        else
            expr = Base.@invokelatest meth.generator(lenv..., meth.generator.argnames...)
            src = generate_lower(codestate, expr)
        end
        codestate.interpstate.meths[(wc, tt)] = (meth, names, lenv, src)
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
            return something(ans)
        end
    end
end
