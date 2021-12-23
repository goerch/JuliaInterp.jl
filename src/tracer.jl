using Test, Random, Distributed, JuliaInterp

function tracer()
    dir = "C:/Users/Win10/Documents/GitHub/JuliaInterp.jl/test/"
    cd(dir)
    try
        # path = "$dir/abstractarray.jl"
        # path = "$dir/ambiguous.jl"
        # path = "$dir/arrayops.jl"
        # path = "$dir/asyncmap.jl"
        # path = "$dir/atexit.jl"
        # path = "$dir/atomics.jl"
        # path = "$dir/backtrace.jl"
        # path = "$dir/binaryplatforms.jl"
        # path = "$dir/bitarray.jl"
        # path = "$dir/bitset.jl"
        # path = "$dir/boundscheck.jl"
        # path = "$dir/broadcast.jl"
        # path = "$dir/cartesian.jl"
        # path = "$dir/ccall.jl"
        # path = "$dir/channels.jl"
        # path = "$dir/char.jl"
        # path = "$dir/checked.jl"
        # path = "$dir/client.jl"
        # path = "$dir/cmdlineargs.jl"
        # path = "$dir/combinatorics.jl"
        # path = "$dir/complex.jl"
        # path = "$dir/copy.jl"
        # path = "$dir/core.jl"
        # path = "$dir/corelogging.jl"
        # path = "$dir/deprecation_exec.jl"
        # path = "$dir/dict.jl"
        # path = "$dir/docs.jl"
        # path = "$dir/download.jl"
        # path = "$dir/enums.jl"
        # path = "$dir/env.jl"
        # path = "$dir/error.jl"
        # path = "$dir/errorshow.jl"
        # path = "$dir/euler.jl"
        # path = "$dir/exceptions.jl"
        # path = "$dir/fastmath.jl"
        # path = "$dir/file.jl"
        # path = "$dir/filesystem.jl"
        # path = "$dir/float16.jl"
        # path = "$dir/floatapprox.jl"
        # path = "$dir/floatfuncs.jl"
        # path = "$dir/functional.jl"
        # path = "$dir/gmp.jl"
        # path = "$dir/goto.jl"
        # path = "$dir/hashing.jl"
        # path = "$dir/int.jl"
        # path = "$dir/interpreter.jl"
        # path = "$dir/intfuncs.jl"
        # path = "$dir/intrinsics.jl"
        # path = "$dir/iobuffer.jl"
        # path = "$dir/iostream.jl"
        # path = "$dir/iterators.jl"
        # path = "$dir/keywordargs.jl"
        # path = "$dir/llvmcall.jl"
        # path = "$dir/llvmcall2.jl"
        # path = "$dir/loading.jl"
        # path = "$dir/math.jl"
        # path = "$dir/meta.jl"
        path = "$dir/misc.jl"
        # path = "$dir/missing.jl"
        # path = "$dir/mod2pi.jl"
        # path = "$dir/mpfr.jl"
        # path = "$dir/namedtuple.jl"
        # path = "$dir/numbers.jl"
        # path = "$dir/offsetarray.jl"
        # path = "$dir/opaque_closure.jl"
        # path = "$dir/operators.jl"
        # path = "$dir/ordering.jl"
        # path = "$dir/osutils.jl"
        # path = "$dir/parse.jl"
        # path = "$dir/path.jl"
        # path = "$dir/precompile.jl"
        # path = "$dir/ranges.jl"
        # path = "$dir/rational.jl"
        # path = "$dir/read.jl"
        # path = "$dir/reduce.jl"
        # path = "$dir/reducedim.jl"
        # path = "$dir/reflection.jl"
        # path = "$dir/regex.jl"
        # path = "$dir/reinterpretarray.jl"
        # path = "$dir/rounding.jl"
        # path = "$dir/ryu.jl"
        # path = "$dir/secretbuffer.jl"
        # path = "$dir/sets.jl"
        # path = "$dir/show.jl"
        # path = "$dir/simdloop.jl"
        # path = "$dir/smallarrayshrink.jl"
        # path = "$dir/some.jl"
        # path = "$dir/sorting.jl"
        # path = "$dir/spawn.jl"
        # path = "$dir/specificity.jl"
        # path = "$dir/stacktraces.jl"
        # path = "$dir/stack_overflow.jl"
        # path = "$dir/staged.jl"
        # path = "$dir/stress.jl"
        # path = "$dir/strings/basic.jl"
        # path = "$dir/strings/io.jl"
        # path = "$dir/strings/search.jl"
        # path = "$dir/strings/types.jl"
        # path = "$dir/strings/util.jl"
        # path = "$dir/subarray.jl"
        # path = "$dir/subtype.jl"
        # path = "$dir/syntax.jl"
        # path = "$dir/sysinfo.jl"
        # path = "$dir/test_sourcepath.jl"
        # path = "$dir/threads.jl"
        # path = "$dir/triplequote.jl"
        # path = "$dir/tuple.jl"
        # path = "$dir/vecelement.jl"
        # path = "$dir/version.jl"
        # path = "$dir/worlds.jl"
        mod = @eval(Main, module IsolatedTests using Base end)
        @eval(mod, using Test, Random, Distributed, JuliaInterp)
        JuliaInterp.include(mod, path, false)
    catch exception
        @show :toplevel exception
        # rethrow(exception)
    finally
        cd("..")
    end
end


