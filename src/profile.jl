using JuliaInterp

# Tight loop
function f(X)
    s = 0
    for x in X
        s += x
    end
    return s
end
const X = rand(1:10, 10_000)

using Profile
Profile.clear()
options = JuliaInterp.options(false, [@__MODULE__], [], UInt(0))
JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(X)"), options)
@profile JuliaInterp.interpret_ast(@__MODULE__, Meta.parse("f(X)"), options)
# Profile.print()
Juno.profiler()
