# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. The interpreter processes IR thunks up to a maximal call stack depth or until reaching `Core` and `Base` methods.

## Installation

Clone the repository from GitHub.

## Running

Change directory to the root folder of the project, 
start Julia (using -t n for the desired number of threads) 
and execute

```
use Pkg
Pkg.activate(".")
include("test/runtests.jl")
```

# Results

Julia 1.8.0-DEV on Windows for a maximal call stack depth of 10:

```
Test Summary:                       |     Pass  Fail  Error  Broken     Total      Time
  Overall                           | 38337125     9     27  352644  38689805  20m17.4s
    LinearAlgebra/schur             |      496                            496   1m05.2s
    LinearAlgebra/lapack            |      803                            803   1m40.7s
    LinearAlgebra/bunchkaufman      |     5688                           5688   1m52.0s
    LinearAlgebra/eigen             |      512                            512   2m14.4s
    LinearAlgebra/tridiag           |     1503                           1503   2m22.8s
    LinearAlgebra/svd               |      566                            566   2m41.2s
    LinearAlgebra/qr                |     4700                           4700   3m34.8s
    LinearAlgebra/generic           |      585                            585   1m15.7s
    LinearAlgebra/special           |     3171                           3171   4m13.4s
    LinearAlgebra/cholesky          |     2474                           2474   3m18.1s
    LinearAlgebra/lq                |     2938                           2938   1m26.5s
    LinearAlgebra/blas              |      756                            756   1m03.4s
    LinearAlgebra/pinv              |      292                            292     22.4s
    LinearAlgebra/uniformscaling    |      591                            591   2m42.6s
    LinearAlgebra/lu                |     1294                           1294   3m35.2s
    LinearAlgebra/givens            |     1847                           1847     11.8s
    LinearAlgebra/ldlt              |        8                              8      2.2s
    LinearAlgebra/factorization     |       80                   16        96      9.3s
    ambiguous                       |      107                    2       109     11.5s
    compiler/validation             |       28                             28      0.6s
    LinearAlgebra/hessenberg        |      604                   11       615   2m06.7s
    LinearAlgebra/bidiag            |     3706                           3706   5m45.5s
    compiler/ssair                  |       40                             40      6.0s
    compiler/irpasses               |       51                    2        53      3.0s
    LinearAlgebra/adjtrans          |      353                            353     49.6s
    compiler/inline                 |      101                            101      3.9s
    compiler/contextual             |       12                             12      3.5s
    strings/search                  |      876                            876     11.8s
    compiler/inference              |     1042                    2      1044     29.9s
    strings/basic                   |    87674                          87674     18.7s
    compiler/codegen                |      164                            164     25.4s
    unicode/utf8                    |       19                             19      0.2s
    strings/io                      |    12764                          12764      6.6s
    strings/types                   |  2302691                        2302691      5.9s
    worlds                          |       88                             88      3.6s
    keywordargs                     |      151                            151      3.0s
    strings/util                    |     1147                           1147     19.4s
    LinearAlgebra/structuredbroadcast |      670                            670   1m26.5s
    atomics                         |     3444                           3444     35.3s
    triplequote                     |       29                             29      0.1s
    char                            |     1628                           1628      4.1s
    intrinsics                      |      301                            301      5.1s
    subtype                         |   337674                   19    337693     40.6s
    iobuffer                        |      209                            209      3.0s
    staged                          |       64                             64      5.1s
    hashing                         |    12519                          12519     29.9s
    dict                            |   144420                         144420     42.5s
    tuple                           |      625                            625     11.6s
    LinearAlgebra/matmul            |     1106                           1106   7m59.6s
    core                            |  8445891                    3   8445894   2m04.3s
    numbers                         |  1578758                    2   1578760   1m55.4s
    LinearAlgebra/dense             |     8475                           8475   8m19.7s
    offsetarray                     |      487                    3       490   1m09.0s
    reduce                          |     8582                           8582     32.6s
    simdloop                        |      240                            240      3.1s
    intfuncs                        |   228049                         228049     14.4s
    copy                            |      533                            533      4.2s
    vecelement                      |      678                            678     15.0s
    fastmath                        |      946                            946     13.0s
    functional                      |       98                             98     10.5s
    rational                        |    98639                    1     98640     48.7s
    operators                       |    13040                          13040     12.9s
    ordering                        |       37                             37      4.4s
    path                            |     1051                   12      1063      2.3s
    reducedim                       |      865                            865   1m40.3s
    parse                           |    16098                          16098      8.3s
    LinearAlgebra/diagonal          |     2795                           2795   8m58.2s
    gmp                             |     2357                           2357     11.7s
    math                            |   148979                         148979   1m41.6s
    arrayops                        |     2031                    2      2033   2m59.0s
    backtrace                       |       38                    1        39      4.3s
    exceptions                      |       70                             70      1.2s
    file                            |        5            1                 6      2.2s
    LinearAlgebra/symmetric         |     2835                           2835   8m31.6s
    version                         |     2452                           2452      1.9s
    spawn                           |      231     1              4       236     34.1s
    namedtuple                      |      215                            215      5.0s
    subarray                        |   318316                         318316   5m23.0s
    abstractarray                   |    55254                24795     80049   3m03.8s
    mpfr                            |     1135                    1      1136     35.2s
    floatapprox                     |       49                             49     14.2s
    complex                         |     8432                    5      8437     26.3s
    regex                           |      130                            130      4.6s
    reflection                      |      415                            415     11.8s
    sysinfo                         |        4                              4      0.4s
    env                             |       94                             94      1.2s
    ccall                           |     5352                           5352   2m12.3s
    float16                         |   762093                         762093     10.4s
    mod2pi                          |       80                             80      0.8s
    rounding                        |   112720                         112720      9.0s
    euler                           |       12                             12      1.9s
    combinatorics                   |      170                            170     15.6s
    client                          |        5                              5      3.5s
    errorshow                       |      238                            238     14.7s
    goto                            |       19                             19      0.1s
    llvmcall                        |       19                             19      0.6s
    llvmcall2                       |        7                              7      0.1s
    ryu                             |    31215                          31215      3.3s
    some                            |       72                             72      1.8s
    meta                            |       69                             69      3.4s
    stacktraces                     |       48                             48      3.5s
    docs                            |      238                            238     10.6s
    sets                            |     3592                    1      3593     45.4s
    iterators                       |    10164                          10164   3m46.5s
    binaryplatforms                 |      341                            341     11.0s
    show                            |   128879                    8    128887   1m06.9s
    enums                           |       99                             99      6.6s
    atexit                          |       40                             40     12.7s
    interpreter                     |        3                              3      2.7s
    read                            |     3725                           3725   2m28.2s
    ranges                          | 12110547               327682  12438229   1m29.2s
    int                             |   524698                         524698     16.8s
    misc                            |  1282211                        1282211     42.6s
    bitset                          |      195                            195      5.0s
    error                           |       31                             31      2.6s
    osutils                         |       57                             57      0.4s
    checked                         |     1239                           1239     17.2s
    iostream                        |       50                             50      2.6s
    secretbuffer                    |       27                             27      1.9s
    specificity                     |      175                            175      0.3s
    broadcast                       |      511                            511   2m29.1s
    cartesian                       |      343                    3       346     13.6s
    boundscheck                     |                                    None     16.3s
    sorting                         |    16096                   10     16106   3m18.8s
    corelogging                     |      231                            231      7.4s
    smallarrayshrink                |       36                             36      1.2s
    opaque_closure                  |       41                    1        42      1.9s
    filesystem                      |        4                              4      0.4s
    syntax                          |     1533                    1      1534     14.0s
    bitarray                        |   916030                         916030   5m21.7s
    reinterpretarray                |      232                            232     23.3s
    channels                        |      258                            258     32.5s
    asyncmap                        |      304                            304     18.5s
    missing                         |      565                    1       566     29.3s
    download                        |                                    None     23.9s
    Dates/accessors                 |  7723858                        7723858     12.2s
    Dates/query                     |     1004                           1004      2.0s
    Dates/adjusters                 |     3149                           3149      9.7s
    Dates/rounding                  |      315                            315      3.7s
    Dates/types                     |      232                            232      3.1s
    Dates/periods                   |      955                            955     30.6s
    Dates/ranges                    |   350637                         350637     30.5s
    Dates/conversions               |      160                            160      1.8s
    Dates/io                        |      331                            331     22.1s
    LibGit2/libgit2                 |      593     1                      594     51.2s
    ArgTools                        |       34     1      4                39      6.0s
    Artifacts                       |     1452                           1452      9.0s
    Dates/arithmetic                |      385                            385     13.3s
    CompilerSupportLibraries_jll    |        4                              4      0.0s
    Base64                          |     2022                           2022      3.8s
    CRC32c                          |      664                            664      4.8s
    Future                          |                                    None      3.1s
    GMP_jll                         |        1                              1      0.2s
    DelimitedFiles                  |       89                             89     10.3s
    LLVMLibUnwind_jll               |                                    None      0.0s
    LazyArtifacts                   |        4                              4      4.1s
    LibCURL                         |        6                              6      1.4s
    LibCURL_jll                     |        1                              1      0.1s
    LibGit2_jll                     |        2                              2      0.1s
    LibSSH2_jll                     |                                    None      0.1s
    LibUV_jll                       |        1                              1      0.1s
    LibUnwind_jll                   |                                    None      0.0s
    Libdl                           |      130                    1       131      1.6s
    Logging                         |       40                             40      3.5s
    MPFR_jll                        |        1                              1      0.1s
    Markdown                        |      257                            257      8.5s
    MbedTLS_jll                     |        1                              1      0.1s
    InteractiveUtils                |      286                    1       287     34.7s
    MozillaCACerts_jll              |        1                              1      0.0s
    FileWatching                    |      468                            468     39.4s
    OpenBLAS_jll                    |        1                              1      0.1s
    OpenLibm_jll                    |        1                              1      0.1s
    PCRE2_jll                       |        2                              2      0.1s
    NetworkOptions                  |     3518                           3518      2.0s
    Mmap                            |      138                            138     22.2s
    Printf                          |     1014                           1014     24.7s
    Profile                         |       86                             86     35.3s
    Downloads                       |      198     1      3               202   1m24.0s
    loading                         |   161509            2            161511   6m30.1s
    REPL                            |     1268     3              4      1275     45.0s
    LinearAlgebra/triangular        |    37844                          37844  16m32.4s
    Serialization                   |      119                    1       120     15.9s
    SuiteSparse_jll                 |        1                              1      0.1s
    TOML                            |      415                    8       423     19.4s
    SparseArrays/higherorderfns     |     7121                    1      7122   3m18.9s
    Tar                             |      280     2     17      11       310     18.2s
    Random                          |   204290                         204290   1m30.3s
    UUIDs                           |     1029                           1029      4.1s
    Zlib_jll                        |        1                              1      0.1s
    dSFMT_jll                       |        1                              1      0.1s
    libLLVM_jll                     |        1                              1      0.1s
    libblastrampoline_jll           |        1                              1      0.1s
    nghttp2_jll                     |        1                              1      0.1s
    p7zip_jll                       |        1                              1      0.0s
    cmdlineargs                     |      255                    3       258   4m36.9s
    Unicode                         |      776                            776      6.7s
    floatfuncs                      |      232                            232   4m25.9s
    Test                            |      451                   18       469     48.9s
    Statistics                      |      801                            801   1m23.4s
    Sockets                         |      170                    1       171   1m31.0s
    SHA                             |      107                            107   1m57.5s
    LinearAlgebra/addmul            |     7326                           7326  13m13.6s
    SparseArrays/sparsevector       |    10348                    4     10352   4m58.1s
    SuiteSparse                     |      921                            921   2m09.8s
    SparseArrays/sparse             |     4027                           4027   6m32.5s
    precompile                      |      123                            123     26.6s
    SharedArrays                    |      114                            114     20.5s
    threads                         |       10                    3        13   2m07.0s
    Distributed                     |       12                             12   2m32.1s
    stress                          |                                    None      0.0s
    FAILURE

The global RNG seed was 0x6e14e053d92930e16591b76f87390af7.
```

# Bonus

Towers of interpretation:

```
using JuliaInterp
JuliaInterp.interprete_ast(Main, Meta.parse("1 + 1"), true)
```

yields

```
:expr = :expr
:call = :call
args = Any[:+, 1, 1]
:eval_lower_ast = :eval_lower_ast
expr = :(1 + 1)
codestate.src = CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = 1 + 1
└──      return %1
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(1 + 1)
:interprete_lower = :interprete_lower
expr = :(1 + 1)
:interprete_lower = :interprete_lower
T = :call
args = Any[:+, 1, 1]
codestate.pc = 2
codestate.src.code[codestate.pc] = :(return %1)
:interprete_lower = :interprete_lower
returnnode = :(return %1)
ans = Some(2)
ans = 2
2
```

and 

```
using JuliaInterp
JuliaInterp.interprete_ast(Main, Meta.parse("using JuliaInterp; JuliaInterp.interprete_ast(Main, Meta.parse(\"1 + 1\"))"), true)
```

yields

```
:expr = :expr
:toplevel = :toplevel
args = Any[:(using JuliaInterp), :(JuliaInterp.interprete_ast(Main, Meta.parse("1 + 1")))]
:expr = :expr
:using = :using
args = Any[:($(Expr(:., :JuliaInterp)))]
:eval_lower_ast = :eval_lower_ast
expr = :(using JuliaInterp)
ans = nothing
:expr = :expr
:call = :call
args = Any[:(JuliaInterp.interprete_ast), :Main, :(Meta.parse("1 + 1"))]
:eval_lower_ast = :eval_lower_ast
expr = :(JuliaInterp.interprete_ast(Main, Meta.parse("1 + 1")))
codestate.src = CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = Base.getproperty(JuliaInterp, :interprete_ast)
│   %2 = Base.getproperty(Meta, :parse)
│   %3 = (%2)("1 + 1")
│   %4 = (%1)(Main, %3)
└──      return %4
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(Base.getproperty(JuliaInterp, :interprete_ast))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(JuliaInterp, :interprete_ast))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :JuliaInterp, :(:interprete_ast)]
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(Meta, :parse))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(Meta, :parse))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :Meta, :(:parse)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :((%2)("1 + 1"))
:interprete_lower = :interprete_lower
expr = :((%2)("1 + 1"))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(%2), "1 + 1"]
codestate.pc = 4
codestate.src.code[codestate.pc] = :((%1)(Main, %3))
:interprete_lower = :interprete_lower
expr = :((%1)(Main, %3))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(%1), :Main, :(%3)]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:198 within `interprete_ast`
1 ─ %1 = (#self#)(mod, expr, false, 10)
└──      return %1
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :((_1)(_2, _3, false, 10))
:interprete_lower = :interprete_lower
expr = :((_1)(_2, _3, false, 10))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(_1), :(_2), :(_3), false, 10]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:198 within `interprete_ast`
1 ─ %1 = JuliaInterp.ModuleState(mod)
│   %2 = Base.vect(%1)
│        interpstate = JuliaInterp.InterpState(debug, 1, maxdepth, %2)
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:199 within `interprete_ast`
│        ans = JuliaInterp.interprete_ast(interpstate, expr)
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:200 within `interprete_ast`
│   %5 = Base.getproperty(interpstate, :mods)
│        JuliaInterp.pop!(%5)
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:201 within `interprete_ast`
└──      return ans
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(JuliaInterp.ModuleState(_2))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.ModuleState(_2))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.ModuleState), :(_2)]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:2 within `ModuleState`
1 ─ %1 = %new(JuliaInterp.ModuleState, mod)
└──      return %1
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(%new(JuliaInterp.ModuleState, _2))
:interprete_lower = :interprete_lower
expr = :(%new(JuliaInterp.ModuleState, _2))
:interprete_lower = :interprete_lower
T = :new
args = Any[:(JuliaInterp.ModuleState), :(_2)]
:eval_ast = :eval_ast
expr = :(%new(JuliaInterp.ModuleState, Main))
ans = JuliaInterp.ModuleState(Main)
codestate.pc = 2
codestate.src.code[codestate.pc] = :(return %1)
:interprete_lower = :interprete_lower
returnnode = :(return %1)
ans = Some(JuliaInterp.ModuleState(Main))
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.vect(%1))
:interprete_lower = :interprete_lower
expr = :(Base.vect(%1))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.vect), :(%1)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(_7 = JuliaInterp.InterpState(_4, 1, _5, %2))
:interprete_lower = :interprete_lower
expr = :(_7 = JuliaInterp.InterpState(_4, 1, _5, %2))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_7), :(JuliaInterp.InterpState(_4, 1, _5, %2))]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:6 within `InterpState`
1 ─ %1 = %new(JuliaInterp.InterpState, debug, depth, maxdepth, mods)
└──      return %1
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(%new(JuliaInterp.InterpState, _2, _3, _4, _5))
:interprete_lower = :interprete_lower
expr = :(%new(JuliaInterp.InterpState, _2, _3, _4, _5))
:interprete_lower = :interprete_lower
T = :new
args = Any[:(JuliaInterp.InterpState), :(_2), :(_3), :(_4), :(_5)]
:eval_ast = :eval_ast
expr = :(%new(JuliaInterp.InterpState, false, 1, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)]))
ans = JuliaInterp.InterpState(false, 1, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)])
codestate.pc = 2
codestate.src.code[codestate.pc] = :(return %1)
:interprete_lower = :interprete_lower
returnnode = :(return %1)
ans = Some(JuliaInterp.InterpState(false, 1, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)]))
codestate.pc = 4
codestate.src.code[codestate.pc] = :(_6 = JuliaInterp.interprete_ast(_7, _3))
:interprete_lower = :interprete_lower
expr = :(_6 = JuliaInterp.interprete_ast(_7, _3))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_6), :(JuliaInterp.interprete_ast(_7, _3))]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:193 within `interprete_ast`
1 ─       Core.NewvarNode(:(value))
│   %2  = Base.getproperty(interpstate, :debug)
└──       goto #3 if not %2
   ┌ @ show.jl:1045 within `macro expansion`
2 ─│ %4  = :expr
│  │       value = %4
│  └
│   %6  = Base.repr(%4)
│         Base.println(":expr = ", %6)
│         value
└──       goto #3
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:194 within `interprete_ast`
3 ┄ %10 = Base.getproperty(expr, :head)
│   %11 = JuliaInterp.Val(%10)
│   %12 = Base.getproperty(expr, :args)
│   %13 = JuliaInterp.interprete_ast(interpstate, %11, %12)
└──       return %13
)
codestate.pc = 1
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_4))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_4))
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:debug)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(goto %10 if not %2)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %10 if not %2)
codestate.pc = 10
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :head))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :head))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:head)]
codestate.pc = 11
codestate.src.code[codestate.pc] = :(JuliaInterp.Val(%10))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.Val(%10))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.Val), :(%10)]
codestate.pc = 12
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :args))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :args))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:args)]
codestate.pc = 13
codestate.src.code[codestate.pc] = :(JuliaInterp.interprete_ast(_2, %11, %12))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.interprete_ast(_2, %11, %12))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.interprete_ast), :(_2), :(%11), :(%12)]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:57 within `interprete_ast`
1 ─       Core.NewvarNode(:(value))
│         Core.NewvarNode(:(expr))
│   %3  = Base.getproperty(interpstate, :debug)
└──       goto #3 if not %3
   ┌ @ show.jl:1045 within `macro expansion`
2 ─│ %5  = :call
│  │       value = %5
│  └
│   %7  = Base.repr(%5)
│         Base.println(":call = ", %7)
│  ┌ @ show.jl:1045 within `macro expansion`
│  │       value = args
│  └
│   %10 = Base.repr(args)
│         Base.println("args = ", %10)
│         value
└──       goto #3
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:58 within `interprete_ast`
3 ┄ %14 = (:call,)
│         expr = Core._apply_iterate(Base.iterate, JuliaInterp.Expr, %14, args)
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:59 within `interprete_ast`
│   %16 = JuliaInterp.eval_lower_ast(interpstate, expr)
└──       return %16
)
codestate.pc = 1
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_5))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_5))
codestate.pc = 2
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_6))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_6))
codestate.pc = 3
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:debug)]
codestate.pc = 4
codestate.src.code[codestate.pc] = :(goto %14 if not %3)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %14 if not %3)
codestate.pc = 14
codestate.src.code[codestate.pc] = (:call,)
:interprete_lower = :interprete_lower
typeof(node) = Tuple{Symbol}
node = (:call,)
codestate.pc = 15
codestate.src.code[codestate.pc] = :(_6 = Core._apply_iterate(Base.iterate, JuliaInterp.Expr, %14, _4))
:interprete_lower = :interprete_lower
expr = :(_6 = Core._apply_iterate(Base.iterate, JuliaInterp.Expr, %14, _4))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_6), :(Core._apply_iterate(Base.iterate, JuliaInterp.Expr, %14, _4))]
codestate.pc = 16
codestate.src.code[codestate.pc] = :(JuliaInterp.eval_lower_ast(_2, _6))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.eval_lower_ast(_2, _6))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.eval_lower_ast), :(_2), :(_6)]
childstate.src = CodeInfo(
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:16 within `eval_lower_ast`
1 ──       Core.NewvarNode(:(value@_4))
│    %2  = Base.getproperty(interpstate, :debug)
└───       goto #3 if not %2
    ┌ @ show.jl:1045 within `macro expansion`
2 ──│ %4  = :eval_lower_ast
│   │       value@_4 = %4
│   └
│    %6  = Base.repr(%4)
│          Base.println(":eval_lower_ast = ", %6)
│   ┌ @ show.jl:1045 within `macro expansion`
│   │       value@_4 = expr
│   └
│    %9  = Base.repr(expr)
│          Base.println("expr = ", %9)
│          value@_4
└───       goto #3
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:17 within `eval_lower_ast`
3 ┄─ %13 = $(Expr(:enter, #11))
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:18 within `eval_lower_ast`
4 ──       Core.NewvarNode(:(value@_5))
│          Core.NewvarNode(:(ans))
│    %16 = Base.getproperty(JuliaInterp.Meta, :lower)
│    %17 = Base.getproperty(interpstate, :mods)
│    %18 = JuliaInterp.last(%17)
│    %19 = Base.getproperty(%18, :mod)
│          lwr = (%16)(%19, expr)
│    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:19 within `eval_lower_ast`
│    %21 = Base.getproperty(lwr, :head)
│    %22 = %21 == :thunk
└───       goto #6 if not %22
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:20 within `eval_lower_ast`
5 ── %24 = Base.getproperty(lwr, :args)
│    %25 = Base.getindex(%24, 1)
│          ans = JuliaInterp.interprete_lower(interpstate, JuliaInterp.nothing, %25)
└───       goto #7
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:22 within `eval_lower_ast`
6 ── %28 = Base.getproperty(interpstate, :mods)
│    %29 = JuliaInterp.last(%28)
│    %30 = Base.getproperty(%29, :mod)
└───       ans = Core.eval(%30, expr)
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:24 within `eval_lower_ast`
7 ┄─ %32 = Base.getproperty(interpstate, :debug)
└───       goto #9 if not %32
    ┌ @ show.jl:1045 within `macro expansion`
8 ──│       value@_5 = ans
│   └
│    %35 = ans
│    %36 = Base.repr(%35)
│          Base.println("ans = ", %36)
│          value@_5
└───       goto #9
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:25 within `eval_lower_ast`
9 ┄─ %40 = ans
└───       $(Expr(:leave, 1))
10 ─       return %40
11 ┄       $(Expr(:leave, 1))
12 ─       Core.NewvarNode(:(value@_8))
│          exception = $(Expr(:the_exception))
│    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:27 within `eval_lower_ast`
│    %46 = exception isa JuliaInterp.AssertionError
│    %47 = !%46
└───       goto #15 if not %47
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:28 within `eval_lower_ast`
13 ─ %49 = Base.getproperty(interpstate, :debug)
└───       goto #15 if not %49
    ┌ @ show.jl:1045 within `macro expansion`
14 ─│ %51 = :eval_lower_ast
│   │       value@_8 = %51
│   └
│    %53 = Base.repr(%51)
│          Base.println(":eval_lower_ast = ", %53)
│   ┌ @ show.jl:1045 within `macro expansion`
│   │       value@_8 = expr
│   └
│    %56 = Base.repr(expr)
│          Base.println("expr = ", %56)
│   ┌ @ show.jl:1045 within `macro expansion`
│   │       value@_8 = exception
│   └
│    %59 = exception
│    %60 = Base.repr(%59)
│          Base.println("exception = ", %60)
│          value@_8
└───       goto #15
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\ast.jl:30 within `eval_lower_ast`
15 ┄ %64 = JuliaInterp.rethrow(exception)
│          $(Expr(:pop_exception, :(%13)))
└───       return %64
)
codestate.pc = 1
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_4))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_4))
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:debug)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(goto %13 if not %2)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %13 if not %2)
codestate.pc = 13
codestate.src.code[codestate.pc] = :($(Expr(:enter, 43)))
:interprete_lower = :interprete_lower
expr = :($(Expr(:enter, 43)))
:interprete_lower = :interprete_lower
:enter = :enter
args = Any[43]
codestate.pc = 14
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_5))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_5))
codestate.pc = 15
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_6))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_6))
codestate.pc = 16
codestate.src.code[codestate.pc] = :(Base.getproperty(JuliaInterp.Meta, :lower))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(JuliaInterp.Meta, :lower))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(JuliaInterp.Meta), :(:lower)]
codestate.pc = 17
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :mods))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :mods))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:mods)]
codestate.pc = 18
codestate.src.code[codestate.pc] = :(JuliaInterp.last(%17))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.last(%17))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.last), :(%17)]
codestate.pc = 19
codestate.src.code[codestate.pc] = :(Base.getproperty(%18, :mod))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%18, :mod))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%18), :(:mod)]
codestate.pc = 20
codestate.src.code[codestate.pc] = :(_7 = (%16)(%19, _3))
:interprete_lower = :interprete_lower
expr = :(_7 = (%16)(%19, _3))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_7), :((%16)(%19, _3))]
codestate.pc = 21
codestate.src.code[codestate.pc] = :(Base.getproperty(_7, :head))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_7, :head))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_7), :(:head)]
codestate.pc = 22
codestate.src.code[codestate.pc] = :(%21 == :thunk)
:interprete_lower = :interprete_lower
expr = :(%21 == :thunk)
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.:(==)), :(%21), :(:thunk)]
codestate.pc = 23
codestate.src.code[codestate.pc] = :(goto %28 if not %22)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %28 if not %22)
codestate.pc = 24
codestate.src.code[codestate.pc] = :(Base.getproperty(_7, :args))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_7, :args))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_7), :(:args)]
codestate.pc = 25
codestate.src.code[codestate.pc] = :(Base.getindex(%24, 1))
:interprete_lower = :interprete_lower
expr = :(Base.getindex(%24, 1))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getindex), :(%24), 1]
codestate.pc = 26
codestate.src.code[codestate.pc] = :(_6 = JuliaInterp.interprete_lower(_2, JuliaInterp.nothing, %25))
:interprete_lower = :interprete_lower
expr = :(_6 = JuliaInterp.interprete_lower(_2, JuliaInterp.nothing, %25))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_6), :(JuliaInterp.interprete_lower(_2, JuliaInterp.nothing, %25))]
childstate.src = CodeInfo(
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:313 within `interprete_lower`
1 ── %1  = Base.getproperty(interpstate, :depth)
│    %2  = %1 + 1
└───       Base.setproperty!(interpstate, :depth, %2)
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:314 within `interprete_lower`
2 ──       $(Expr(:enter, #7))
3 ──       @_7 = -1
│    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:315 within `interprete_lower`
│          Core.NewvarNode(:(value))
│          codestate = JuliaInterp.code_state_from_thunk(interpstate, src)
│    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:316 within `interprete_lower`
│    %8  = Base.getproperty(codestate, :interpstate)
│    %9  = Base.getproperty(%8, :debug)
└───       goto #5 if not %9
    ┌ @ show.jl:1045 within `macro expansion`
4 ──│ %11 = Base.getproperty(codestate, :src)
│   │       value = %11
│   └
│    %13 = Base.repr(%11)
│          Base.println("codestate.src = ", %13)
│          value
└───       goto #5
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:317 within `interprete_lower`
5 ┄─       @_8 = JuliaInterp.run_code_state(codestate)
│          @_7 = 1
└───       $(Expr(:leave, 1))
6 ──       goto #9
7 ┄─       $(Expr(:leave, 1))
8 ──       @_7 = 2
     @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:319 within `interprete_lower`
9 ┄─ %23 = Base.getproperty(interpstate, :depth)
│    %24 = %23 - 1
│          Base.setproperty!(interpstate, :depth, %24)
│    %26 = @_7 === 2
└───       goto #11 if not %26
10 ─       Base.rethrow()
11 ┄       return @_8
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :depth))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :depth))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:depth)]
codestate.pc = 2
codestate.src.code[codestate.pc] = :(%1 + 1)
:interprete_lower = :interprete_lower
expr = :(%1 + 1)
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.:+), :(%1), 1]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(Base.setproperty!(_2, :depth, %2))
:interprete_lower = :interprete_lower
expr = :(Base.setproperty!(_2, :depth, %2))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.setproperty!), :(_2), :(:depth), :(%2)]
codestate.pc = 4
codestate.src.code[codestate.pc] = :($(Expr(:enter, 21)))
:interprete_lower = :interprete_lower
expr = :($(Expr(:enter, 21)))
:interprete_lower = :interprete_lower
:enter = :enter
args = Any[21]
codestate.pc = 5
codestate.src.code[codestate.pc] = :(_7 = -1)
:interprete_lower = :interprete_lower
expr = :(_7 = -1)
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_7), -1]
codestate.pc = 6
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_5))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_5))
codestate.pc = 7
codestate.src.code[codestate.pc] = :(_6 = JuliaInterp.code_state_from_thunk(_2, _4))
:interprete_lower = :interprete_lower
expr = :(_6 = JuliaInterp.code_state_from_thunk(_2, _4))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_6), :(JuliaInterp.code_state_from_thunk(_2, _4))]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:25 within `code_state_from_thunk`
1 ─ %1  = Base.vect()
│   %2  = Core.svec
│   %3  = (%2)()
│   %4  = Base.getproperty(src, :code)
│   %5  = JuliaInterp.length(%4)
│   %6  = JuliaInterp.Vector(JuliaInterp.undef, %5)
│   %7  = Base.getproperty(src, :slotnames)
│   %8  = JuliaInterp.length(%7)
│   %9  = JuliaInterp.Vector(JuliaInterp.undef, %8)
│   %10 = Base.getindex(JuliaInterp.Int)
│   %11 = Base.getindex(JuliaInterp.Exception)
│   %12 = JuliaInterp.CodeState(interpstate, src, %1, %3, 1, %6, %9, %10, %11)
└──       return %12
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(Base.vect())
:interprete_lower = :interprete_lower
expr = :(Base.vect())
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.vect)]
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Core.svec)
:interprete_lower = :interprete_lower
typeof(node) = GlobalRef
node = :(Core.svec)
codestate.pc = 3
codestate.src.code[codestate.pc] = :((%2)())
:interprete_lower = :interprete_lower
expr = :((%2)())
:interprete_lower = :interprete_lower
T = :call
args = Any[:(%2)]
codestate.pc = 4
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :code))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :code))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:code)]
codestate.pc = 5
codestate.src.code[codestate.pc] = :(JuliaInterp.length(%4))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.length(%4))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.length), :(%4)]
codestate.pc = 6
codestate.src.code[codestate.pc] = :(JuliaInterp.Vector(JuliaInterp.undef, %5))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.Vector(JuliaInterp.undef, %5))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.Vector), :(JuliaInterp.undef), :(%5)]
codestate.pc = 7
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :slotnames))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :slotnames))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:slotnames)]
codestate.pc = 8
codestate.src.code[codestate.pc] = :(JuliaInterp.length(%7))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.length(%7))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.length), :(%7)]
codestate.pc = 9
codestate.src.code[codestate.pc] = :(JuliaInterp.Vector(JuliaInterp.undef, %8))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.Vector(JuliaInterp.undef, %8))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.Vector), :(JuliaInterp.undef), :(%8)]
codestate.pc = 10
codestate.src.code[codestate.pc] = :(Base.getindex(JuliaInterp.Int))
:interprete_lower = :interprete_lower
expr = :(Base.getindex(JuliaInterp.Int))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getindex), :(JuliaInterp.Int)]
codestate.pc = 11
codestate.src.code[codestate.pc] = :(Base.getindex(JuliaInterp.Exception))
:interprete_lower = :interprete_lower
expr = :(Base.getindex(JuliaInterp.Exception))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getindex), :(JuliaInterp.Exception)]
codestate.pc = 12
codestate.src.code[codestate.pc] = :(JuliaInterp.CodeState(_2, _3, %1, %3, 1, %6, %9, %10, %11))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.CodeState(_2, _3, %1, %3, 1, %6, %9, %10, %11))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.CodeState), :(_2), :(_3), :(%1), :(%3), 1, :(%6), :(%9), :(%10), :(%11)]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:13 within `CodeState`
1 ─ %1  = JuliaInterp.CodeState
│   %2  = Core.fieldtype(%1, 1)
│   %3  = Base.convert(%2, interpstate)
│   %4  = Core.fieldtype(%1, 2)
│   %5  = Base.convert(%4, src)
│   %6  = Core.fieldtype(%1, 3)
│   %7  = Base.convert(%6, names)
│   %8  = Core.fieldtype(%1, 4)
│   %9  = Base.convert(%8, lenv)
│   %10 = Core.fieldtype(%1, 5)
│   %11 = Base.convert(%10, pc)
│   %12 = Core.fieldtype(%1, 6)
│   %13 = Base.convert(%12, ssavalues)
│   %14 = Core.fieldtype(%1, 7)
│   %15 = Base.convert(%14, slots)
│   %16 = Core.fieldtype(%1, 8)
│   %17 = Base.convert(%16, handlers)
│   %18 = Core.fieldtype(%1, 9)
│   %19 = Base.convert(%18, exceptions)
│   %20 = %new(%1, %3, %5, %7, %9, %11, %13, %15, %17, %19)
└──       return %20
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(JuliaInterp.CodeState)
:interprete_lower = :interprete_lower
typeof(node) = GlobalRef
node = :(JuliaInterp.CodeState)
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 1))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 1))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 1]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(Base.convert(%2, _2))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%2, _2))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%2), :(_2)]
codestate.pc = 4
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 2))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 2))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 2]
codestate.pc = 5
codestate.src.code[codestate.pc] = :(Base.convert(%4, _3))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%4, _3))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%4), :(_3)]
codestate.pc = 6
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 3))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 3))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 3]
codestate.pc = 7
codestate.src.code[codestate.pc] = :(Base.convert(%6, _4))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%6, _4))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%6), :(_4)]
codestate.pc = 8
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 4))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 4))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 4]
codestate.pc = 9
codestate.src.code[codestate.pc] = :(Base.convert(%8, _5))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%8, _5))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%8), :(_5)]
codestate.pc = 10
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 5))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 5))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 5]
codestate.pc = 11
codestate.src.code[codestate.pc] = :(Base.convert(%10, _6))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%10, _6))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%10), :(_6)]
codestate.pc = 12
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 6))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 6))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 6]
codestate.pc = 13
codestate.src.code[codestate.pc] = :(Base.convert(%12, _7))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%12, _7))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%12), :(_7)]
codestate.pc = 14
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 7))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 7))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 7]
codestate.pc = 15
codestate.src.code[codestate.pc] = :(Base.convert(%14, _8))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%14, _8))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%14), :(_8)]
codestate.pc = 16
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 8))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 8))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 8]
codestate.pc = 17
codestate.src.code[codestate.pc] = :(Base.convert(%16, _9))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%16, _9))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%16), :(_9)]
codestate.pc = 18
codestate.src.code[codestate.pc] = :(Core.fieldtype(%1, 9))
:interprete_lower = :interprete_lower
expr = :(Core.fieldtype(%1, 9))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.fieldtype), :(%1), 9]
codestate.pc = 19
codestate.src.code[codestate.pc] = :(Base.convert(%18, _10))
:interprete_lower = :interprete_lower
expr = :(Base.convert(%18, _10))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.convert), :(%18), :(_10)]
codestate.pc = 20
codestate.src.code[codestate.pc] = :(%new(%1, %3, %5, %7, %9, %11, %13, %15, %17, %19))
:interprete_lower = :interprete_lower
expr = :(%new(%1, %3, %5, %7, %9, %11, %13, %15, %17, %19))
:interprete_lower = :interprete_lower
T = :new
args = Any[:(%1), :(%3), :(%5), :(%7), :(%9), :(%11), :(%13), :(%15), :(%17), :(%19)]
:eval_ast = :eval_ast
expr = :(%new(JuliaInterp.CodeState, JuliaInterp.InterpState(false, 2, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)]), CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = 1 + 1
└──      return %1
), Symbol[], svec(), 1, Any[#undef, #undef], Any[], Int64[], Exception[]))
ans = JuliaInterp.CodeState(JuliaInterp.InterpState(false, 2, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)]), CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = 1 + 1
└──      return %1
), Symbol[], svec(), 1, Any[#undef, #undef], Any[], Int64[], Exception[])
codestate.pc = 21
codestate.src.code[codestate.pc] = :(return %20)
:interprete_lower = :interprete_lower
returnnode = :(return %20)
ans = Some(JuliaInterp.CodeState(JuliaInterp.InterpState(false, 2, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)]), CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = 1 + 1
└──      return %1
), Symbol[], svec(), 1, Any[#undef, #undef], Any[], Int64[], Exception[]))
codestate.pc = 13
codestate.src.code[codestate.pc] = :(return %12)
:interprete_lower = :interprete_lower
returnnode = :(return %12)
ans = Some(JuliaInterp.CodeState(JuliaInterp.InterpState(false, 2, 10, JuliaInterp.ModuleState[JuliaInterp.ModuleState(Main)]), CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = 1 + 1
└──      return %1
), Symbol[], svec(), 1, Any[#undef, #undef], Any[], Int64[], Exception[]))
codestate.pc = 8
codestate.src.code[codestate.pc] = :(Base.getproperty(_6, :interpstate))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_6, :interpstate))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_6), :(:interpstate)]
codestate.pc = 9
codestate.src.code[codestate.pc] = :(Base.getproperty(%8, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%8, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%8), :(:debug)]
codestate.pc = 10
codestate.src.code[codestate.pc] = :(goto %17 if not %9)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %17 if not %9)
codestate.pc = 17
codestate.src.code[codestate.pc] = :(_8 = JuliaInterp.run_code_state(_6))
:interprete_lower = :interprete_lower
expr = :(_8 = JuliaInterp.run_code_state(_6))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_8), :(JuliaInterp.run_code_state(_6))]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:61 within `run_code_state`
1 ─       goto #9 if not true
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:62 within `run_code_state`
2 ─       Core.NewvarNode(:(value@_3))
│         Core.NewvarNode(:(value@_4))
│         Core.NewvarNode(:(ans))
│   %5  = Base.getproperty(codestate, :interpstate)
│   %6  = Base.getproperty(%5, :debug)
└──       goto #4 if not %6
   ┌ @ show.jl:1045 within `macro expansion`
3 ─│ %8  = Base.getproperty(codestate, :pc)
│  │       value@_4 = %8
│  └
│   %10 = Base.repr(%8)
│         Base.println("codestate.pc = ", %10)
│  ┌ @ show.jl:1045 within `macro expansion`
│  │ %12 = Base.getproperty(codestate, :src)
│  │ %13 = Base.getproperty(%12, :code)
│  │ %14 = Base.getproperty(codestate, :pc)
│  │ %15 = Base.getindex(%13, %14)
│  │       value@_4 = %15
│  └
│   %17 = Base.repr(%15)
│         Base.println("codestate.src.code[codestate.pc] = ", %17)
│         value@_4
└──       goto #4
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:63 within `run_code_state`
4 ┄ %21 = Base.getproperty(codestate, :src)
│   %22 = Base.getproperty(%21, :code)
│   %23 = Base.getproperty(codestate, :pc)
│   %24 = Base.getindex(%22, %23)
│         ans = JuliaInterp.interprete_lower(codestate, %24)
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:64 within `run_code_state`
│   %26 = ans isa JuliaInterp.Some
└──       goto #8 if not %26
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:65 within `run_code_state`
5 ─ %28 = Base.getproperty(codestate, :interpstate)
│   %29 = Base.getproperty(%28, :debug)
└──       goto #7 if not %29
   ┌ @ show.jl:1045 within `macro expansion`
6 ─│       value@_3 = ans
│  └
│   %32 = ans
│   %33 = Base.repr(%32)
│         Base.println("ans = ", %33)
│         value@_3
└──       goto #7
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:66 within `run_code_state`
7 ┄ %37 = Base.getproperty(ans, :value)
└──       return %37
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\types.jl:68 within `run_code_state`
8 ─       goto #1
9 ─       return nothing
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(goto %40 if not true)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %40 if not true)
codestate.pc = 2
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_3))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_3))
codestate.pc = 3
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_4))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_4))
codestate.pc = 4
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_5))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_5))
codestate.pc = 5
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:interpstate)]
codestate.pc = 6
codestate.src.code[codestate.pc] = :(Base.getproperty(%5, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%5, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%5), :(:debug)]
codestate.pc = 7
codestate.src.code[codestate.pc] = :(goto %21 if not %6)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %21 if not %6)
codestate.pc = 21
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :src))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :src))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:src)]
codestate.pc = 22
codestate.src.code[codestate.pc] = :(Base.getproperty(%21, :code))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%21, :code))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%21), :(:code)]
codestate.pc = 23
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :pc))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :pc))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:pc)]
codestate.pc = 24
codestate.src.code[codestate.pc] = :(Base.getindex(%22, %23))
:interprete_lower = :interprete_lower
expr = :(Base.getindex(%22, %23))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getindex), :(%22), :(%23)]
codestate.pc = 25
codestate.src.code[codestate.pc] = :(_5 = JuliaInterp.interprete_lower(_2, %24))
:interprete_lower = :interprete_lower
expr = :(_5 = JuliaInterp.interprete_lower(_2, %24))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_5), :(JuliaInterp.interprete_lower(_2, %24))]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:306 within `interprete_lower`
1 ─       Core.NewvarNode(:(value))
│   %2  = Base.getproperty(codestate, :interpstate)
│   %3  = Base.getproperty(%2, :debug)
└──       goto #3 if not %3
   ┌ @ show.jl:1045 within `macro expansion`
2 ─│ %5  = :interprete_lower
│  │       value = %5
│  └
│   %7  = Base.repr(%5)
│         Base.println(":interprete_lower = ", %7)
│  ┌ @ show.jl:1045 within `macro expansion`
│  │       value = expr
│  └
│   %10 = Base.repr(expr)
│         Base.println("expr = ", %10)
│         value
└──       goto #3
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:307 within `interprete_lower`
3 ┄ %14 = Base.getproperty(expr, :head)
│   %15 = JuliaInterp.Val(%14)
│   %16 = Base.getproperty(expr, :args)
│         JuliaInterp.interprete_lower(codestate, %15, %16)
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:308 within `interprete_lower`
└──       return JuliaInterp.nothing
)
codestate.pc = 1
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_4))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_4))
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:interpstate)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(Base.getproperty(%2, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%2, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%2), :(:debug)]
codestate.pc = 4
codestate.src.code[codestate.pc] = :(goto %14 if not %3)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %14 if not %3)
codestate.pc = 14
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :head))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :head))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:head)]
codestate.pc = 15
codestate.src.code[codestate.pc] = :(JuliaInterp.Val(%14))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.Val(%14))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.Val), :(%14)]
codestate.pc = 16
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :args))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :args))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:args)]
codestate.pc = 17
codestate.src.code[codestate.pc] = :(JuliaInterp.interprete_lower(_2, %15, %16))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.interprete_lower(_2, %15, %16))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.interprete_lower), :(_2), :(%15), :(%16)]
codestate.pc = 18
codestate.src.code[codestate.pc] = :(return JuliaInterp.nothing)
:interprete_lower = :interprete_lower
returnnode = :(return JuliaInterp.nothing)
ans = Some(nothing)
codestate.pc = 26
codestate.src.code[codestate.pc] = :(_5 isa JuliaInterp.Some)
:interprete_lower = :interprete_lower
expr = :(_5 isa JuliaInterp.Some)
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.isa), :(_5), :(JuliaInterp.Some)]
codestate.pc = 27
codestate.src.code[codestate.pc] = :(goto %39 if not %26)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %39 if not %26)
codestate.pc = 39
codestate.src.code[codestate.pc] = :(goto %1)
:interprete_lower = :interprete_lower
gotonode = :(goto %1)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(goto %40 if not true)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %40 if not true)
codestate.pc = 2
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_3))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_3))
codestate.pc = 3
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_4))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_4))
codestate.pc = 4
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_5))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_5))
codestate.pc = 5
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:interpstate)]
codestate.pc = 6
codestate.src.code[codestate.pc] = :(Base.getproperty(%5, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%5, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%5), :(:debug)]
codestate.pc = 7
codestate.src.code[codestate.pc] = :(goto %21 if not %6)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %21 if not %6)
codestate.pc = 21
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :src))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :src))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:src)]
codestate.pc = 22
codestate.src.code[codestate.pc] = :(Base.getproperty(%21, :code))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%21, :code))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%21), :(:code)]
codestate.pc = 23
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :pc))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :pc))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:pc)]
codestate.pc = 24
codestate.src.code[codestate.pc] = :(Base.getindex(%22, %23))
:interprete_lower = :interprete_lower
expr = :(Base.getindex(%22, %23))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getindex), :(%22), :(%23)]
codestate.pc = 25
codestate.src.code[codestate.pc] = :(_5 = JuliaInterp.interprete_lower(_2, %24))
:interprete_lower = :interprete_lower
expr = :(_5 = JuliaInterp.interprete_lower(_2, %24))
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_5), :(JuliaInterp.interprete_lower(_2, %24))]
childstate.src = CodeInfo(
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:282 within `interprete_lower`
1 ─       Core.NewvarNode(:(value))
│   %2  = Base.getproperty(codestate, :interpstate)
│   %3  = Base.getproperty(%2, :debug)
└──       goto #3 if not %3
   ┌ @ show.jl:1045 within `macro expansion`
2 ─│ %5  = :interprete_lower
│  │       value = %5
│  └
│   %7  = Base.repr(%5)
│         Base.println(":interprete_lower = ", %7)
│  ┌ @ show.jl:1045 within `macro expansion`
│  │       value = returnnode
│  └
│   %10 = Base.repr(returnnode)
│         Base.println("returnnode = ", %10)
│         value
└──       goto #3
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:283 within `interprete_lower`
3 ┄ %14 = $(Expr(:enter, #6))
    @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:284 within `interprete_lower`
4 ─ %15 = Base.getproperty(returnnode, :val)
│   %16 = JuliaInterp.lookup_lower(codestate, %15)
│   %17 = JuliaInterp.Some(%16)
└──       $(Expr(:leave, 1))
5 ─       return %17
6 ┄       $(Expr(:leave, 1))
7 ─       exception = $(Expr(:the_exception))
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:286 within `interprete_lower`
│         JuliaInterp.handle_error(codestate, exception)
│         $(Expr(:pop_exception, :(%14)))
│   @ C:\Users\Win10\Documents\GitHub\JuliaInterp.jl\src\lower.jl:288 within `interprete_lower`
└──       return JuliaInterp.nothing
)
codestate.pc = 1
codestate.src.code[codestate.pc] = Core.NewvarNode(:(_4))
:interprete_lower = :interprete_lower
typeof(node) = Core.NewvarNode
node = Core.NewvarNode(:(_4))
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:interpstate)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :(Base.getproperty(%2, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%2, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%2), :(:debug)]
codestate.pc = 4
codestate.src.code[codestate.pc] = :(goto %14 if not %3)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %14 if not %3)
codestate.pc = 14
codestate.src.code[codestate.pc] = :($(Expr(:enter, 20)))
:interprete_lower = :interprete_lower
expr = :($(Expr(:enter, 20)))
:interprete_lower = :interprete_lower
:enter = :enter
args = Any[20]
codestate.pc = 15
codestate.src.code[codestate.pc] = :(Base.getproperty(_3, :val))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_3, :val))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_3), :(:val)]
codestate.pc = 16
codestate.src.code[codestate.pc] = :(JuliaInterp.lookup_lower(_2, %15))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.lookup_lower(_2, %15))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.lookup_lower), :(_2), :(%15)]
codestate.pc = 17
codestate.src.code[codestate.pc] = :(JuliaInterp.Some(%16))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.Some(%16))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.Some), :(%16)]
codestate.pc = 18
codestate.src.code[codestate.pc] = :($(Expr(:leave, 1)))
:interprete_lower = :interprete_lower
expr = :($(Expr(:leave, 1)))
:interprete_lower = :interprete_lower
:leave = :leave
args = Any[1]
codestate.pc = 19
codestate.src.code[codestate.pc] = :(return %17)
:interprete_lower = :interprete_lower
returnnode = :(return %17)
ans = Some(Some(2))
codestate.pc = 26
codestate.src.code[codestate.pc] = :(_5 isa JuliaInterp.Some)
:interprete_lower = :interprete_lower
expr = :(_5 isa JuliaInterp.Some)
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.isa), :(_5), :(JuliaInterp.Some)]
codestate.pc = 27
codestate.src.code[codestate.pc] = :(goto %39 if not %26)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %39 if not %26)
codestate.pc = 28
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :interpstate))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:interpstate)]
codestate.pc = 29
codestate.src.code[codestate.pc] = :(Base.getproperty(%28, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(%28, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(%28), :(:debug)]
codestate.pc = 30
codestate.src.code[codestate.pc] = :(goto %37 if not %29)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %37 if not %29)
codestate.pc = 37
codestate.src.code[codestate.pc] = :(Base.getproperty(_5, :value))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_5, :value))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_5), :(:value)]
codestate.pc = 38
codestate.src.code[codestate.pc] = :(return %37)
:interprete_lower = :interprete_lower
returnnode = :(return %37)
ans = Some(2)
codestate.pc = 18
codestate.src.code[codestate.pc] = :(_7 = 1)
:interprete_lower = :interprete_lower
expr = :(_7 = 1)
:interprete_lower = :interprete_lower
:(=) = :(=)
args = Any[:(_7), 1]
codestate.pc = 19
codestate.src.code[codestate.pc] = :($(Expr(:leave, 1)))
:interprete_lower = :interprete_lower
expr = :($(Expr(:leave, 1)))
:interprete_lower = :interprete_lower
:leave = :leave
args = Any[1]
codestate.pc = 20
codestate.src.code[codestate.pc] = :(goto %23)
:interprete_lower = :interprete_lower
gotonode = :(goto %23)
codestate.pc = 23
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :depth))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :depth))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:depth)]
codestate.pc = 24
codestate.src.code[codestate.pc] = :(%23 - 1)
:interprete_lower = :interprete_lower
expr = :(%23 - 1)
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.:-), :(%23), 1]
codestate.pc = 25
codestate.src.code[codestate.pc] = :(Base.setproperty!(_2, :depth, %24))
:interprete_lower = :interprete_lower
expr = :(Base.setproperty!(_2, :depth, %24))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.setproperty!), :(_2), :(:depth), :(%24)]
codestate.pc = 26
codestate.src.code[codestate.pc] = :(_7 === 2)
:interprete_lower = :interprete_lower
expr = :(_7 === 2)
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Core.:(===)), :(_7), 2]
codestate.pc = 27
codestate.src.code[codestate.pc] = :(goto %29 if not %26)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %29 if not %26)
codestate.pc = 29
codestate.src.code[codestate.pc] = :(return _8)
:interprete_lower = :interprete_lower
returnnode = :(return _8)
ans = Some(2)
codestate.pc = 27
codestate.src.code[codestate.pc] = :(goto %32)
:interprete_lower = :interprete_lower
gotonode = :(goto %32)
codestate.pc = 32
codestate.src.code[codestate.pc] = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_2, :debug))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_2), :(:debug)]
codestate.pc = 33
codestate.src.code[codestate.pc] = :(goto %40 if not %32)
:interprete_lower = :interprete_lower
gotoifnot = :(goto %40 if not %32)
codestate.pc = 40
codestate.src.code[codestate.pc] = :(_6)
:interprete_lower = :interprete_lower
typeof(node) = Core.SlotNumber
node = :(_6)
codestate.pc = 41
codestate.src.code[codestate.pc] = :($(Expr(:leave, 1)))
:interprete_lower = :interprete_lower
expr = :($(Expr(:leave, 1)))
:interprete_lower = :interprete_lower
:leave = :leave
args = Any[1]
codestate.pc = 42
codestate.src.code[codestate.pc] = :(return %40)
:interprete_lower = :interprete_lower
returnnode = :(return %40)
ans = Some(2)
codestate.pc = 17
codestate.src.code[codestate.pc] = :(return %16)
:interprete_lower = :interprete_lower
returnnode = :(return %16)
ans = Some(2)
codestate.pc = 14
codestate.src.code[codestate.pc] = :(return %13)
:interprete_lower = :interprete_lower
returnnode = :(return %13)
ans = Some(2)
codestate.pc = 5
codestate.src.code[codestate.pc] = :(Base.getproperty(_7, :mods))
:interprete_lower = :interprete_lower
expr = :(Base.getproperty(_7, :mods))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(Base.getproperty), :(_7), :(:mods)]
codestate.pc = 6
codestate.src.code[codestate.pc] = :(JuliaInterp.pop!(%5))
:interprete_lower = :interprete_lower
expr = :(JuliaInterp.pop!(%5))
:interprete_lower = :interprete_lower
T = :call
args = Any[:(JuliaInterp.pop!), :(%5)]
codestate.pc = 7
codestate.src.code[codestate.pc] = :(return _6)
:interprete_lower = :interprete_lower
returnnode = :(return _6)
ans = Some(2)
codestate.pc = 2
codestate.src.code[codestate.pc] = :(return %1)
:interprete_lower = :interprete_lower
returnnode = :(return %1)
ans = Some(2)
codestate.pc = 5
codestate.src.code[codestate.pc] = :(return %4)
:interprete_lower = :interprete_lower
returnnode = :(return %4)
ans = Some(2)
ans = 2
2
```