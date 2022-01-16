using JuliaInterp

# Recursively call itself
f(i, j) = i == 0 ? j : f(i - 1, j + 1)

using Profile
Profile.clear()
options = JuliaInterp.options(false, false, [@__MODULE__], [], UInt(0))
JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(1_000, 0)"), options)
@profile JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(1_000, 0)"), options)
# Profile.print()
Juno.profiler()

# Tight loop
#= function f(X)
    s = 0
    for x in X
        s += x
    end
    return s
end
const X = rand(1:10, 10_000)

using Profile
Profile.clear()
options = JuliaInterp.options(false, false, [@__MODULE__], [], UInt(0))
JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(X)"), options)
@profile JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(X)"), options)
# Profile.print()
Juno.profiler() =#

#= include("tracer.jl")

using Profile
Profile.clear()
@profile try tracer(["arrayops.jl"]); catch end
# Profile.print()
Juno.profiler() =#
