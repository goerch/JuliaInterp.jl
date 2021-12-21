using Test, Random, Distributed, JuliaInterp

dir = "C:/Users/Win10/Documents/GitHub/JuliaInterp.jl/test/"
try
    # path = "$dir/core.jl"
    # path = "$dir/numbers.jl"
    # path = "$dir/arrayops.jl"
    # path = "$dir/syntax.jl"
    path = "$dir/show.jl"
    # path = "$dir/subtype.jl"
    # path = "$dir/ranges.jl"
    # path = "$dir/bitarray.jl"
    # path = "$dir/ccall.jl"
    # path = "$dir/copy.jl"
    JuliaInterp.include(Main, path, true, 3)
catch exception
    @show :toplevel exception
    # rethrow(exception)
end