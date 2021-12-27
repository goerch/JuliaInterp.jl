using Test, Random, Distributed, Compat, JuliaInterp

function tracer()
    dir = "C:/Users/Win10/Documents/GitHub/JuliaInterp.jl/test/"
    cd(dir)
    try
        for path in [
            #= "abstractarray.jl",
            "ambiguous.jl",
            "arrayops.jl",
            "asyncmap.jl",
            "atexit.jl",
            "atomics.jl",
            "backtrace.jl",
            "binaryplatforms.jl",
            "bitarray.jl",
            "bitset.jl",
            "boundscheck.jl",
            "broadcast.jl",
            "cartesian.jl",
            "ccall.jl",
            "channels.jl",
            "char.jl",
            "checked.jl",
            "client.jl",
            "cmdlineargs.jl",
            "combinatorics.jl",
            "complex.jl", 
            "copy.jl",
            "core.jl",
            "corelogging.jl",
            "deprecation_exec.jl",
            "dict.jl",
            "docs.jl",
            "download.jl",
            "enums.jl",
            "env.jl",
            "error.jl",
            "errorshow.jl",
            "euler.jl",
            "exceptions.jl",
            "fastmath.jl",
            "file.jl",
            "filesystem.jl",
            "float16.jl",
            "floatapprox.jl",
            "floatfuncs.jl",
            "functional.jl",
            "gmp.jl",
            "goto.jl",
            "hashing.jl",
            "int.jl", =#
            "interpreter.jl"
            #= "intfuncs.jl",
            "intrinsics.jl",
            "iobuffer.jl",
            "iostream.jl",
            "iterators.jl",
            "keywordargs.jl",
            "llvmcall.jl",
            "llvmcall2.jl",
            "loading.jl",
            "math.jl",
            "meta.jl",
            "misc.jl",
            "missing.jl",
            "mod2pi.jl",
            "mpfr.jl",
            "namedtuple.jl",
            "numbers.jl",
            "offsetarray.jl",
            "opaque_closure.jl",
            "operators.jl",
            "ordering.jl",
            "osutils.jl",
            "parse.jl",
            "path.jl",
            "precompile.jl",
            "ranges.jl",
            "rational.jl",
            "read.jl",
            "reduce.jl",
            "reducedim.jl",
            "reflection.jl",
            "regex.jl",
            "reinterpretarray.jl",
            "rounding.jl",
            "ryu.jl",
            "secretbuffer.jl",
            "sets.jl",
            "show.jl",
            "simdloop.jl",
            "smallarrayshrink.jl",
            "some.jl",
            "sorting.jl",
            "spawn.jl",
            "specificity.jl",
            "stacktraces.jl",
            "stack_overflow.jl",
            "staged.jl",
            "stress.jl",
            "strings/basic.jl",
            "strings/io.jl",
            "strings/search.jl",
            "strings/types.jl",
            "strings/util.jl",
            "subarray.jl",
            "subtype.jl",
            "syntax.jl",
            "sysinfo.jl",
            "test_sourcepath.jl", 
            "threads.jl",
            "triplequote.jl",
            "tuple.jl",
            "vecelement.jl",
            "version.jl",
            "worlds.jl",
            "testdefs.jl" =#]
            try
                mod = @eval(Main, module IsolatedTests using Base, Test, Random, Distributed, Compat, JuliaInterp; end)
                @testset verbose=true begin
                    JuliaInterp.include(mod, path, false)
                end
            catch exception
                @show :toplevel exception
                rethrow(exception)
            end
        end
    finally
        cd("..")
    end
end


