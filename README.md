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
  Overall                           | 38324390     9     27  352644  38677070  20m07.6s
    LinearAlgebra/schur             |      496                            496   1m04.6s
    LinearAlgebra/lapack            |      803                            803   1m41.9s
    LinearAlgebra/bunchkaufman      |     5688                           5688   1m47.4s
    LinearAlgebra/eigen             |      512                            512   2m16.1s
    LinearAlgebra/tridiag           |     1503                           1503   2m22.0s
    LinearAlgebra/svd               |      566                            566   2m40.6s
    LinearAlgebra/qr                |     4700                           4700   3m31.0s
    LinearAlgebra/generic           |      585                            585   1m14.6s
    LinearAlgebra/special           |     3171                           3171   4m14.1s
    LinearAlgebra/lq                |     2938                           2938   1m27.4s
    LinearAlgebra/cholesky          |     2474                           2474   3m22.0s
    LinearAlgebra/blas              |      756                            756   1m03.5s
    LinearAlgebra/pinv              |      292                            292     17.0s
    LinearAlgebra/lu                |     1294                           1294   3m35.1s
    LinearAlgebra/uniformscaling    |      591                            591   2m42.1s
    LinearAlgebra/ldlt              |        8                              8      2.5s
    LinearAlgebra/givens            |     1847                           1847     12.2s
    LinearAlgebra/factorization     |       80                   16        96      7.3s
    ambiguous                       |      107                    2       109     11.3s
    compiler/validation             |       28                             28      0.6s
    LinearAlgebra/hessenberg        |      604                   11       615   2m08.2s
    LinearAlgebra/bidiag            |     3706                           3706   5m45.0s
    compiler/irpasses               |       51                    2        53      3.2s
    compiler/ssair                  |       40                             40      6.3s
    LinearAlgebra/adjtrans          |      353                            353     51.8s
    compiler/contextual             |       12                             12      3.5s
    compiler/inline                 |      101                            101      3.9s
    compiler/inference              |     1042                    2      1044     28.5s
    strings/search                  |      876                            876     10.4s
    strings/io                      |    12764                          12764      6.7s
    strings/basic                   |    87674                          87674     18.0s
    compiler/codegen                |      164                            164     24.8s
    unicode/utf8                    |       19                             19      0.2s
    worlds                          |       88                             88      3.1s
    strings/types                   |  2302691                        2302691      6.3s
    keywordargs                     |      151                            151      2.9s
    strings/util                    |     1147                           1147     20.3s
    LinearAlgebra/structuredbroadcast |      670                            670   1m26.1s
    atomics                         |     3444                           3444     35.9s
    triplequote                     |       29                             29      0.1s
    char                            |     1628                           1628      4.1s
    intrinsics                      |      301                            301      5.3s
    subtype                         |   337674                   19    337693     43.6s
    iobuffer                        |      209                            209      3.0s
    staged                          |       64                             64      4.8s
    hashing                         |    12519                          12519     30.5s
    dict                            |   144420                         144420     45.5s
    LinearAlgebra/matmul            |     1106                           1106   7m46.2s
    tuple                           |      625                            625     12.7s
    numbers                         |  1578758                    2   1578760   1m56.6s
    core                            |  8445891                    3   8445894   2m07.0s
    LinearAlgebra/dense             |     8475                           8475   8m20.9s
    reduce                          |     8582                           8582     36.6s
    offsetarray                     |      487                    3       490   1m10.1s
    simdloop                        |      240                            240      3.1s
    intfuncs                        |   227979                         227979     16.5s
    vecelement                      |      678                            678     14.3s
    copy                            |      533                            533      4.3s
    fastmath                        |      946                            946     15.2s
    functional                      |       98                             98     10.6s
    rational                        |    98639                    1     98640     50.0s
    operators                       |    13040                          13040     13.9s
    reducedim                       |      865                            865   1m40.6s
    ordering                        |       37                             37      4.6s
    path                            |     1051                   12      1063      2.4s
    parse                           |    16098                          16098      7.9s
    LinearAlgebra/diagonal          |     2795                           2795   9m10.9s
    math                            |   148979                         148979   1m47.9s
    gmp                             |     2357                           2357     11.2s
    arrayops                        |     2031                    2      2033   3m05.0s
    backtrace                       |       38                    1        39      4.7s
    exceptions                      |       70                             70      1.2s
    file                            |        5            1                 6      2.3s
    LinearAlgebra/symmetric         |     2835                           2835   8m41.4s
    version                         |     2452                           2452      2.2s
    spawn                           |      231     1              4       236     38.2s
    namedtuple                      |      215                            215      5.6s
    subarray                        |   318316                         318316   5m34.4s
    abstractarray                   |    55263                24795     80058   3m14.4s
    mpfr                            |     1135                    1      1136     35.7s
    floatapprox                     |       49                             49     14.0s
    regex                           |      130                            130      4.4s
    ccall                           |     5352                           5352   2m17.1s
    reflection                      |      415                            415     10.8s
    sysinfo                         |        4                              4      0.4s
    complex                         |     8432                    5      8437     27.9s
    env                             |       94                             94      1.2s
    float16                         |   762093                         762093     10.0s
    mod2pi                          |       80                             80      0.8s
    euler                           |       12                             12      1.8s
    rounding                        |   112720                         112720      9.0s
    combinatorics                   |      170                            170     15.8s
    client                          |        5                              5      3.6s
    errorshow                       |      238                            238     12.4s
    goto                            |       19                             19      0.1s
    llvmcall                        |       19                             19      0.6s
    llvmcall2                       |        7                              7      0.1s
    ryu                             |    31215                          31215      3.2s
    some                            |       72                             72      1.9s
    meta                            |       69                             69      2.6s
    stacktraces                     |       48                             48      4.1s
    docs                            |      238                            238      7.7s
    sets                            |     3592                    1      3593     45.8s
    iterators                       |    10164                          10164   3m48.9s
    binaryplatforms                 |      341                            341     11.3s
    atexit                          |       40                             40     12.4s
    enums                           |       99                             99      6.7s
    read                            |     3725                           3725   2m24.1s
    interpreter                     |        3                              3      2.4s
    show                            |   128879                    8    128887   1m14.9s
    misc                            |  1282219                        1282219     42.0s
    bitset                          |      195                            195      4.5s
    ranges                          | 12110584               327682  12438266   1m30.4s
    int                             |   524698                         524698     16.3s
    error                           |       31                             31      2.1s
    osutils                         |       57                             57      0.2s
    checked                         |     1239                           1239     16.5s
    iostream                        |       50                             50      2.8s
    secretbuffer                    |       27                             27      1.3s
    specificity                     |      175                            175      0.5s
    boundscheck                     |                                    None     17.0s
    cartesian                       |      343                    3       346     13.8s
    LinearAlgebra/addmul            |     3582                           3582   8m20.5s
    broadcast                       |      511                            511   2m33.6s
    corelogging                     |      231                            231      8.9s
    sorting                         |    16096                   10     16106   3m23.3s
    smallarrayshrink                |       36                             36      0.9s
    syntax                          |     1533                    1      1534     12.2s
    filesystem                      |        4                              4      0.4s
    opaque_closure                  |       41                    1        42      1.5s
    bitarray                        |   914510                         914510   5m29.3s
    channels                        |      258                            258     28.6s
    reinterpretarray                |      232                            232     25.3s
    asyncmap                        |      304                            304     17.2s
    Dates/accessors                 |  7723858                        7723858     10.8s
    Dates/query                     |     1004                           1004      1.9s
    download                        |                                    None     23.9s
    Dates/adjusters                 |     3149                           3149      9.8s
    missing                         |      565                    1       566     32.7s
    Dates/rounding                  |      315                            315      3.9s
    Dates/types                     |      232                            232      3.7s
    Dates/arithmetic                |      385                            385     14.4s
    Dates/conversions               |      160                            160      1.9s
    Dates/io                        |      331                            331     23.8s
    Dates/periods                   |      955                            955     29.5s
    ArgTools                        |       34     1      4                39      6.7s
    LibGit2/libgit2                 |      593     1                      594     48.6s
    Dates/ranges                    |   350637                         350637     32.2s
    Base64                          |     2022                           2022      4.2s
    CompilerSupportLibraries_jll    |        4                              4      0.0s
    CRC32c                          |      664                            664      1.3s
    Artifacts                       |     1452                           1452      9.9s
    Future                          |                                    None      0.0s
    GMP_jll                         |        1                              1      0.0s
    DelimitedFiles                  |       89                             89      9.4s
    LLVMLibUnwind_jll               |                                    None      3.3s
    LazyArtifacts                   |        4                              4      4.2s
    LibCURL                         |        6                              6      1.4s
    LibCURL_jll                     |        1                              1      0.1s
    LibSSH2_jll                     |                                    None      0.1s
    LibGit2_jll                     |        2                              2      0.1s
    LibUnwind_jll                   |                                    None      0.0s
    LibUV_jll                       |        1                              1      0.1s
    Libdl                           |      127                    1       128      1.5s
    MPFR_jll                        |        1                              1      0.1s
    Logging                         |       40                             40      3.9s
    MbedTLS_jll                     |        1                              1      0.1s
    Markdown                        |      257                            257      8.6s
    MozillaCACerts_jll              |        1                              1      0.0s
    NetworkOptions                  |     3518                           3518      1.9s
    OpenBLAS_jll                    |        1                              1      0.1s
    OpenLibm_jll                    |        1                              1      0.1s
    PCRE2_jll                       |        2                              2      0.1s
    Mmap                            |      138                            138     10.1s
    InteractiveUtils                |      286                    1       287     35.9s
    FileWatching                    |      468                            468     42.8s
    Printf                          |     1014                           1014     22.8s
    Profile                         |       86                             86     32.3s
    Serialization                   |      119                    1       120     11.9s
    loading                         |   154057            2            154059   6m30.7s
    REPL                            |     1268     3              4      1275     44.0s
    Downloads                       |      198     1      3               202   1m26.2s
    SuiteSparse_jll                 |        1                              1      3.4s
    LinearAlgebra/triangular        |    37844                          37844  16m47.3s
    TOML                            |      415                    8       423     21.2s
    Random                          |   204290                         204290   1m30.6s
    UUIDs                           |     1029                           1029      0.6s
    Tar                             |      280     2     17      11       310     19.4s
    Unicode                         |      776                            776      7.4s
    Zlib_jll                        |        1                              1      0.1s
    dSFMT_jll                       |        1                              1      0.1s
    libLLVM_jll                     |        1                              1      0.0s
    libblastrampoline_jll           |        1                              1      0.1s
    nghttp2_jll                     |        1                              1      0.1s
    p7zip_jll                       |        1                              1      0.0s
    SparseArrays/higherorderfns     |     7121                    1      7122   3m25.3s
    Sockets                         |      170                    1       171   1m28.2s
    floatfuncs                      |      232                            232   4m07.5s
    cmdlineargs                     |      255                    3       258   4m32.7s
    Test                            |      451                   18       469     48.2s
    SHA                             |      107                            107   2m07.6s
    Statistics                      |      801                            801   1m33.9s
    SuiteSparse                     |      921                            921   2m08.1s
    SparseArrays/sparsevector       |    10348                    4     10352   4m46.1s
    SparseArrays/sparse             |     4027                           4027   6m17.3s
    precompile                      |      123                            123     27.0s
    SharedArrays                    |      114                            114     21.7s
    threads                         |       10                    3        13   1m39.7s
    Distributed                     |       12                             12   2m40.0s
    stress                          |                                    None      0.0s
    FAILURE

The global RNG seed was 0x622d644dc91c8b5631d8f1352b474a0c.
```

# Bonus

Towers of interpretation:

```
using JuliaInterp
JuliaInterp.interprete_ast(Module(), Meta.parse("x = 1"))
```

yields

```
1
```

and 

```
JuliaInterp.interprete_ast(Module(), JuliaInterp.interprete_ast(Module(), Meta.parse("x = 1")))
```

still yields

```
1
```