using JuliaInterp
using BenchmarkTools

const SUITE = BenchmarkGroup()

options = JuliaInterp.options(false, [], UInt(0))

# Recursively call itself
f(i, j) = i == 0 ? j : f(i - 1, j + 1)
SUITE["recursive self 1_000"] = @benchmarkable JuliaInterp.interpret_ast(Main, Meta.parse("f(1_000, 0)"), options)

# Long stack trace calling other functions
f0(i) = i
for i in 1:1_000
    @eval $(Symbol("f", i))(i) = $(Symbol("f", i-1))(i)
end
SUITE["recursive other 1_000"] = @benchmarkable Base.@invokelatest JuliaInterp.interpret_ast(Main, Meta.parse("f1000(1)"), options)

# Tight loop
function f(X)
    s = 0
    for x in X
        s += x
    end
    return s
end
const X = rand(1:10, 10_000)
SUITE["tight loop 10_000"] = @benchmarkable JuliaInterp.interpret_ast(Main, Meta.parse("f(X)"), options)

# Throwing and catching an error over a large stacktrace
function g0(i)
    try
        g1(i)
    catch e
        e
    end
end
for i in 1:1_000
    @eval $(Symbol("g", i))(i) = $(Symbol("g", i+1))(i)
end
g1001(i) = error()
SUITE["throw long 1_000"] = @benchmarkable JuliaInterp.interpret_ast(Main, Meta.parse("g0(1)"), options) 

# Function with many statements
macro do_thing(expr, N)
    e = Expr(:block)
    for i in 1:N
        push!(e.args, esc(expr))
    end
    return e
end

function counter()
    a = 0
    @do_thing(a = a + 1, 5_000)
    return a
end
SUITE["long function 5_000"] = @benchmarkable JuliaInterp.interpret_ast(Main, Meta.parse("counter()"), options) 

# Ccall
function ccall_ptr(ptr, x, y)
    ccall(ptr, Int, (Int, Int), x, y)
end
const ptr = @cfunction(+, Int, (Int, Int))
SUITE["ccall ptr"] = @benchmarkable JuliaInterp.interpret_ast(Main, Meta.parse("ccall_ptr(ptr, 1, 5)"), options) 

function powf(a, b)
    ccall(("powf", Base.Math.libm), Float32, (Float32,Float32), a, b)
end
SUITE["ccall library"] = @benchmarkable JuliaInterp.interpret_ast(Main, Meta.parse("powf(2, 3)"), options) 