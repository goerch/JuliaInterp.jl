using JuliaInterp

# Recursively call itself
#= f(i, j) = i == 0 ? j : f(i - 1, j + 1)

using Profile
Profile.clear()
options = JuliaInterp.options(false, false, [@__MODULE__], [], UInt(0))
JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(1_000, 0)"), options)
@profile JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(1_000, 0)"), options)
# Profile.print()
Juno.profiler() =#

# Long stack trace calling other functions
f0(i) = i
for i in 1:1_000
    @eval $(Symbol("f", i))(i) = $(Symbol("f", i-1))(i)
end

using Profile
Profile.clear()
options = JuliaInterp.options(false, false, [@__MODULE__], [], UInt(0))
JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f1000(1)"), options)
@profile for i in 1:10 JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f1000(1)"), options); end
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
@profile for i in 1:10 JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(X)"), options); end
# Profile.print()
Juno.profiler() =#

#= include("tracer.jl")

using Profile
Profile.clear()
@profile try tracer(["arrayops.jl"]); catch end
# Profile.print()
Juno.profiler() =#
