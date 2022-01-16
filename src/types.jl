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
            # parms = (ErrorException("rethrow() not allowed outside a catch block"),)
            parms = Any[ErrorException("rethrow() not allowed outside a catch block")]
        else
            # parms = (pop!(codestate.interpstate.exceptions).exception,)
            parms = Any[pop!(codestate.interpstate.exceptions).exception]
        end
    elseif isempty(codestate.interpstate.exceptions)
        # parms = (ErrorException("rethrow(exc) not allowed outside a catch block"),)
        parms = Any[ErrorException("rethrow(exc) not allowed outside a catch block")]
    end
    return Base.throw(parms...)
end
# https://github.com/JuliaLang/julia/issues/43556
function _iolock_begin(codestate, parms)
    # @show :_iolock_begin codestate.interpstate.iolock codestate.src
    # if !codestate.interpstate.iolock
    #     Base.iolock_begin(parms...)
    #     codestate.interpstate.iolock = true
    # end
    return nothing
end
function _iolock_end(codestate, parms)
    # @show :_iolock_end codestate.interpstate.iolock codestate.src
    # if codestate.interpstate.iolock
    #     codestate.interpstate.iolock = false
    #     Base.iolock_end(parms...)
    # end
    return nothing
end
function _sigatomic_begin(codestate, parms)
    # @show :_sigatomic_begin codestate.interpstate.sigatomic codestate.src
    # if !codestate.interpstate.sigatomic
        Base.sigatomic_begin(parms...)
        codestate.interpstate.sigatomic = true
    # end
    return nothing
end
function _sigatomic_end(codestate, parms)
    # @show :_sigatomic_end codestate.interpstate.sigatomic codestate.src
    if codestate.interpstate.sigatomic
        codestate.interpstate.sigatomic = false
        Base.sigatomic_end(parms...)
    end
    return nothing
end
function _llvmcall(codestate, parms)
    # @show :_llvmcall parms
    funname = gensym("llvmcall")
    argnames = ((Symbol(:(_), i) for i = 1:length(parms) - 3)...,)
    ir = parms[1]
    rt = parms[2]
    at = parms[3]
    return eval_ast(codestate.interpstate, moduleof(codestate.mod_or_meth),
        quote
            function $funname($(argnames...))
                Base.llvmcall($ir, $rt, $at, $(argnames...))
            end
            $funname($(parms[4:end]...))
        end)
end
function _eval(codestate, parms)
    wc1 = Base.get_world_counter()
    @show :_eval Int(wc1)
    if length(parms) == 1
        ans = interpret_ast(moduleof(codestate.mod_or_meth), parms[1],
            codestate.interpstate.options)
    else
        ans = interpret_ast(parms[1], parms[2],
            codestate.interpstate.options)
    end
    wc2 = Base.get_world_counter()
    @show :_eval Int(wc2)
    return ans
end

struct InterpOptions
    debug::Bool
    stats::Bool
    modules::Vector{Module}
    limiteds::Vector{Module}
    budget::UInt
end

function options(debug, stats, modules, limiteds, budget)
    InterpOptions(debug, stats, modules, limiteds, budget)
end

const Callsite = Union{Ptr{Nothing}, Base.InterpreterIP}

const ModuleOrMethod = Union{Module, Method}

moduleof(meth::Method) = meth.module
moduleof(mod::Module) = mod

const WorldType = Tuple{UInt, Type}

typeof_lower(type::Type) = Type{type}
typeof_lower(val) = typeof(val)

function world_type(callable, parms)
    wc = Base.get_world_counter()
    t = Base.to_tuple_type(typeof_lower.(parms))
    tt = Base.signature_type(callable, t)
    (wc, tt)
end

function _which(wt)
    #= try
        return which(wt[2])
    catch exception
        @show :_which exception
        if !(exception isa ErrorException)
            rethrow()
        else
            return nothing
        end
    end =#
    @static if VERSION >= v"1.8.0-DEV"
        # Adapted Base._which
        min_valid = Base.RefValue{UInt}(typemin(UInt))
        max_valid = Base.RefValue{UInt}(typemax(UInt))
        match = ccall(:jl_gf_invoke_lookup_worlds, Any,
            (Any, UInt, Ptr{Csize_t}, Ptr{Csize_t}),
            wt[2], wt[1], min_valid, max_valid)
        return match
        #= if match isa Core.MethodMatch
            return match.method
        else
            return nothing
        end =#
    else
        return ccall(:jl_gf_invoke_lookup, Any, (Any, UInt), wt[2], wt[1])
    end
end

mutable struct Statistics
    calls::UInt
    elapsed::UInt
end

mutable struct InterpState
    options::InterpOptions
    wc::UInt
    intercepts::Dict{Base.Callable, Base.Callable}
    meths::Dict{WorldType, Tuple{Method, Core.SimpleVector, Core.CodeInfo}}
    stats::Dict{ModuleOrMethod, Statistics}
    exceptions::Vector{NamedTuple{(:exception, :backtrace), Tuple{Any, Vector{<:Callsite}}}}
    iolock::Bool
    sigatomic::Bool
end

function interp_state(mod, options)
    wc = Base.get_world_counter()
    interpstate = InterpState(options, wc, Dict(), Dict(), Dict(), [], false, false)
    @static if !isdefined(Base, :current_exceptions)
        interpstate.intercepts[Base.catch_stack] = _current_exceptions
    else
        interpstate.intercepts[Base.current_exceptions] = _current_exceptions
    end
    interpstate.intercepts[Base.catch_backtrace] = _catch_backtrace
    interpstate.intercepts[Base.rethrow] = _rethrow
    interpstate.intercepts[Base.iolock_begin] = _iolock_begin
    interpstate.intercepts[Base.iolock_end] = _iolock_end
    interpstate.intercepts[Base.sigatomic_begin] = _sigatomic_begin
    interpstate.intercepts[Base.sigatomic_end] = _sigatomic_end
    interpstate.intercepts[Base.llvmcall] = _llvmcall
    interpstate.intercepts[Core.Intrinsics.llvmcall] = _llvmcall
    # interpstate.intercepts[Core.eval] = _eval
    # interpstate.intercepts[Base.eval] = _eval
    # interpstate.intercepts[mod.eval] = _eval
    # union!(interpstate.passthroughs, intrinsics())
    # union!(interpstate.passthroughs, builtins())
    #= push!(interpstate.passthroughs, Core.eval)
    push!(interpstate.passthroughs, Base.eval)
    push!(interpstate.passthroughs, getfield(mod, :eval))
    push!(interpstate.passthroughs, Base.lock)
    push!(interpstate.passthroughs, Base.unlock) =#
    interpstate
end

function update_interp_statistics(interpstate::InterpState, mod_or_meth, time)
    if !haskey(interpstate.stats, mod_or_meth)
        interpstate.stats[mod_or_meth] = Statistics(UInt(1), time)
    else
        interpstate.stats[mod_or_meth].calls += UInt(1)
        interpstate.stats[mod_or_meth].elapsed += time
    end
end

function check_interp_statistics(interpstate::InterpState, mod_or_meth)
    interpstate.options.budget == 0 ||
    !haskey(interpstate.stats, mod_or_meth) ||
    interpstate.stats[mod_or_meth].elapsed < interpstate.options.budget
end


mutable struct CodeState
    interpstate::InterpState
    wt::WorldType
    mod_or_meth::ModuleOrMethod
    sparam_vals::Core.SimpleVector
    src::Core.CodeInfo
    pc::Int
    cc::Int
    ssavalues::Vector{Any}
    childstates::Vector{Vector{Tuple{Base.Callable, Union{Nothing, CodeState}}}}
    childstats::Vector{Statistics}
    slots::Vector{Any}
    handlers::Vector{Int}
end

const ChildState = Tuple{Base.Callable, Union{Nothing, CodeState}}

function code_state_from_thunk(interpstate, mod, src)
    # @show :code_state_from_thunk
    wc = Base.get_world_counter()
    CodeState(interpstate, (wc, Nothing), mod, Core.svec(), src, 1, 1,
        Vector{Any}(undef, length(src.code)),
        Vector{Vector{ChildState}}(undef, length(src.code)),
        Vector{Statistics}(undef, length(src.code)),
        Vector{Any}(undef, length(src.slotnames)),
        Int[])
end

generate_lower(codestate::CodeState, expr::Expr) = Meta.lower(moduleof(codestate.mod_or_meth), expr)
generate_lower(codestate::CodeState, val) = val

function code_state_from_call(codestate::CodeState, wt)
    # @show :code_state_from_call
    if !haskey(codestate.interpstate.meths, wt)
        @static if VERSION >= v"1.8.0-DEV"
            match = _which(wt)
            if match === nothing
                @show :code_state_from_call wt match
                return nothing
            end
            meth = match.method
            mi = Core.Compiler.specialize_method(match)
            sparam_vals = mi.sparam_vals
        else
            meth = _which(wt)
            if meth === nothing
                @show :code_state_from_call wt meth
                return nothing
            end
            (ti, sparam_vals) = ccall(:jl_type_intersection_with_env, Any, (Any, Any), wt[2], meth.sig)
        end
        if !isdefined(meth, :generator)
            src = Base.uncompressed_ast(meth)
            # src = Base.uncompressed_ir(meth)
        else
            generator = meth.generator
            if codestate.mod_or_meth isa Module
                expr_or_src = Base.invokelatest(generator, sparam_vals..., generator.argnames...)
            else
                # expr_or_src = generator(sparam_vals..., generator.argnames...)
                expr_or_src = Base.invokelatest(generator, sparam_vals..., generator.argnames...)
            end
            if expr_or_src isa Core.CodeInfo
                src = expr_or_src
            elseif expr_or_src isa Expr
                expr = expr_or_src
                src = generate_lower(codestate, expr)
            else
                @show expr_or_src
                @assert false
            end
        end
        codestate.interpstate.meths[wt] = (meth, sparam_vals, src)
    else
        meth, sparam_vals, src = codestate.interpstate.meths[wt]
    end
    CodeState(codestate.interpstate, wt, meth, sparam_vals, src, 1, 1,
        Vector{Any}(undef, length(src.code)),
        Vector{Vector{ChildState}}(undef, length(src.code)),
        Vector{Statistics}(undef, length(src.code)),
        Vector{Any}(undef, length(src.slotnames)),
        Int[])
end

function update_code_state(codestate::CodeState, callable, parms)
    codestate.pc = 1
    codestate.ssavalues = Vector{Any}(undef, length(codestate.src.code))
    # codestate.childstats = Vector{Statistics}(undef, length(codestate.src.code))
    codestate.slots = Vector{Any}(undef, length(codestate.src.slotnames))
    empty!(codestate.handlers)
    meth = codestate.mod_or_meth::Method
    codestate.slots[1] = callable
    if !meth.isva
        @views codestate.slots[2:meth.nargs] .= parms[1:meth.nargs - 1]
    else
        @views codestate.slots[2:meth.nargs - 1] .= parms[1:meth.nargs - 2]
        # codestate.slots[meth.nargs] = parms[meth.nargs - 1:end]
        codestate.slots[meth.nargs] = (parms[meth.nargs - 1:end]...,)
    end
    codestate
end

function update_code_statistics(codestate::CodeState, time)
    if !isassigned(codestate.childstats, codestate.pc)
        codestate.childstats[codestate.pc] = Statistics(UInt(1), time)
    else
        codestate.childstats[codestate.pc].calls += UInt(1)
        codestate.childstats[codestate.pc].elapsed += time
    end
end

function check_code_statistics(codestate::CodeState)
    codestate.interpstate.options.budget == 0 ||
    !isassigned(codestate.childstats, codestate.pc) ||
    codestate.childstats[codestate.pc].elapsed < codestate.interpstate.options.budget
end
