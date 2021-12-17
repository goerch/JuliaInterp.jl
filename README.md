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
include("test/runtests")
```

# Results

Julia 1.8.0-DEV on Windows for a maximal call stack depth of 10:

```
Test Summary:                       |     Pass  Fail  Error  Broken     Total      Time
  Overall                           | 38326169     9     27  352644  38678849  21m39.5s
    LinearAlgebra/schur             |      496                            496   1m10.1s
    LinearAlgebra/lapack            |      803                            803   1m49.8s
    LinearAlgebra/bunchkaufman      |     5688                           5688   1m56.3s
    LinearAlgebra/eigen             |      512                            512   2m23.8s
    LinearAlgebra/tridiag           |     1503                           1503   2m31.2s
    LinearAlgebra/svd               |      566                            566   2m50.3s
    LinearAlgebra/qr                |     4700                           4700   3m40.6s
    LinearAlgebra/generic           |      585                            585   1m14.8s
    LinearAlgebra/special           |     3171                           3171   4m22.3s
    LinearAlgebra/lq                |     2938                           2938   1m30.0s
    LinearAlgebra/cholesky          |     2474                           2474   3m26.3s
    LinearAlgebra/blas              |      756                            756   1m04.7s
    LinearAlgebra/pinv              |      292                            292     17.7s
    LinearAlgebra/uniformscaling    |      591                            591   2m45.6s
    LinearAlgebra/lu                |     1294                           1294   3m39.6s
    LinearAlgebra/ldlt              |        8                              8      2.3s
    LinearAlgebra/givens            |     1847                           1847     12.4s
    LinearAlgebra/factorization     |       80                   16        96      7.8s
    ambiguous                       |      107                    2       109     11.7s
    compiler/validation             |       28                             28      0.6s
    compiler/ssair                  |       40                             40      6.2s
    LinearAlgebra/hessenberg        |      604                   11       615   2m12.7s
    compiler/irpasses               |       51                    2        53      2.9s
    LinearAlgebra/adjtrans          |      353                            353     52.7s
    LinearAlgebra/bidiag            |     3706                           3706   6m03.6s
    compiler/inline                 |      101                            101      4.0s
    compiler/contextual             |       12                             12      3.7s
    compiler/inference              |     1042                    2      1044     29.9s
    strings/search                  |      876                            876     12.5s
    strings/basic                   |    87674                          87674     19.2s
    compiler/codegen                |      164                            164     27.7s
    strings/io                      |    12764                          12764      7.0s
    unicode/utf8                    |       19                             19      0.3s
    strings/types                   |  2302691                        2302691      6.3s
    worlds                          |       88                             88      4.5s
    keywordargs                     |      151                            151      5.0s
    strings/util                    |     1147                           1147     23.2s
    LinearAlgebra/structuredbroadcast |      670                            670   1m31.9s
    char                            |     1628                           1628      4.5s
    triplequote                     |       29                             29      0.1s
    atomics                         |     3444                           3444     40.3s
    intrinsics                      |      301                            301      5.9s
    subtype                         |   337674                   19    337693     45.9s
    iobuffer                        |      209                            209      3.0s
    staged                          |       64                             64      5.1s
    hashing                         |    12519                          12519     32.1s
    dict                            |   144420                         144420     44.5s
    LinearAlgebra/matmul            |     1106                           1106   8m03.9s
    tuple                           |      625                            625     11.1s
    numbers                         |  1578758                    2   1578760   2m01.1s
    LinearAlgebra/dense             |     8475                           8475   8m41.4s
    reduce                          |     8582                           8582     37.5s
    core                            |  8445891                    3   8445894   2m15.6s
    offsetarray                     |      487                    3       490   1m10.6s
    simdloop                        |      240                            240      3.5s
    vecelement                      |      678                            678     15.9s
    intfuncs                        |   227715                         227715     17.0s
    copy                            |      533                            533      4.3s
    fastmath                        |      946                            946     14.6s
    functional                      |       98                             98     11.2s
    rational                        |    98639                    1     98640     51.2s
    operators                       |    13040                          13040     13.8s
    reducedim                       |      865                            865   1m42.7s
    path                            |     1051                   12      1063      2.5s
    ordering                        |       37                             37      5.2s
    math                            |   148979                         148979     56.0s
    parse                           |    16098                          16098      7.4s
    gmp                             |     2357                           2357     10.1s
    LinearAlgebra/diagonal          |     2795                           2795   9m24.6s
    arrayops                        |     2031                    2      2033   3m07.2s
    backtrace                       |       38                    1        39      5.2s
    exceptions                      |       70                             70      1.2s
    file                            |        5            1                 6      2.7s
    spawn                           |      231     1              4       236     39.3s
    LinearAlgebra/symmetric         |     2835                           2835   8m59.3s
    version                         |     2452                           2452      5.6s
    namedtuple                      |      215                            215      5.5s
    subarray                        |   318316                         318316   5m43.3s
    abstractarray                   |    55180                24795     79975   3m17.6s
    ccall                           |     5352                           5352   2m10.5s
    mpfr                            |     1135                    1      1136     37.1s
    regex                           |      130                            130      4.2s
    floatapprox                     |       49                             49     15.2s
    reflection                      |      415                            415      9.5s
    sysinfo                         |        4                              4      0.4s
    env                             |       94                             94      1.2s
    complex                         |     8432                    5      8437     27.7s
    float16                         |   762093                         762093     10.9s
    mod2pi                          |       80                             80      1.0s
    rounding                        |   112720                         112720      9.8s
    euler                           |       12                             12      2.2s
    combinatorics                   |      170                            170     16.8s
    client                          |        5                              5      3.6s
    errorshow                       |      238                            238     15.7s
    goto                            |       19                             19      0.1s
    llvmcall                        |       19                             19      0.7s
    llvmcall2                       |        7                              7      0.1s
    ryu                             |    31215                          31215      3.4s
    some                            |       72                             72      2.0s
    meta                            |       69                             69      3.5s
    stacktraces                     |       48                             48      4.1s
    docs                            |      238                            238     10.7s
    sets                            |     3592                    1      3593     48.0s
    iterators                       |    10164                          10164   3m57.1s
    binaryplatforms                 |      341                            341     11.0s
    show                            |   128879                    8    128887   1m07.9s
    enums                           |       99                             99      5.1s
    atexit                          |       40                             40     12.0s
    sorting                         |    16096                   10     16106   3m26.5s
    interpreter                     |        3                              3      2.5s
    read                            |     3725                           3725   2m29.8s
    bitset                          |      195                            195      4.7s
    ranges                          | 12110496               327682  12438178   1m32.7s
    broadcast                       |      511                            511   2m20.0s
    int                             |   524698                         524698     17.6s
    osutils                         |       57                             57      0.2s
    error                           |       31                             31      2.3s
    iostream                        |       50                             50      2.7s
    misc                            |  1282217                        1282217     45.5s
    specificity                     |      175                            175      0.8s
    checked                         |     1239                           1239     16.1s
    secretbuffer                    |       27                             27      2.1s
    boundscheck                     |                                    None     17.1s
    corelogging                     |      231                            231      7.5s
    cartesian                       |      343                    3       346     14.7s
    smallarrayshrink                |       36                             36      1.0s
    opaque_closure                  |       41                    1        42      1.5s
    filesystem                      |        4                              4      0.4s
    syntax                          |     1533                    1      1534     12.7s
    bitarray                        |   916430                         916430   5m27.3s
    channels                        |      258                            258     25.5s
    reinterpretarray                |      232                            232     25.7s
    asyncmap                        |      304                            304     19.1s
    download                        |                                    None     25.0s
    missing                         |      565                    1       566     32.0s
    Dates/accessors                 |  7723858                        7723858     13.1s
    Dates/query                     |     1004                           1004      2.1s
    Dates/adjusters                 |     3149                           3149     10.9s
    Dates/rounding                  |      315                            315      3.9s
    Dates/types                     |      232                            232      3.5s
    Dates/periods                   |      955                            955     30.8s
    Dates/ranges                    |   350637                         350637     32.4s
    Dates/conversions               |      160                            160      1.9s
    Dates/io                        |      331                            331     23.0s
    LibGit2/libgit2                 |      593     1                      594     56.2s
    ArgTools                        |       34     1      4                39      5.9s
    Dates/arithmetic                |      385                            385     12.7s
    Base64                          |     2022                           2022      3.6s
    Artifacts                       |     1452                           1452      9.9s
    CompilerSupportLibraries_jll    |        4                              4      0.0s
    CRC32c                          |      664                            664      1.3s
    DelimitedFiles                  |       89                             89     10.5s
    GMP_jll                         |        1                              1      0.1s
    Future                          |                                    None      3.3s
    LLVMLibUnwind_jll               |                                    None      0.2s
    LazyArtifacts                   |        4                              4      4.2s
    LibCURL                         |        6                              6      1.3s
    LibCURL_jll                     |        1                              1      0.1s
    LibGit2_jll                     |        2                              2      0.1s
    LibSSH2_jll                     |                                    None      0.1s
    LibUV_jll                       |        1                              1      0.1s
    LibUnwind_jll                   |                                    None      0.0s
    Libdl                           |      129                    1       130      1.4s
    Logging                         |       40                             40      4.4s
    MPFR_jll                        |        1                              1      0.1s
    Markdown                        |      257                            257      8.1s
    MbedTLS_jll                     |        1                              1      0.1s
    Mmap                            |      138                            138      8.4s
    MozillaCACerts_jll              |        1                              1      0.0s
    NetworkOptions                  |     3518                           3518      1.9s
    OpenBLAS_jll                    |        1                              1      0.1s
    OpenLibm_jll                    |        1                              1      0.1s
    PCRE2_jll                       |        2                              2      0.1s
    FileWatching                    |      468                            468     43.0s
    InteractiveUtils                |      286                    1       287     34.4s
    loading                         |   147421            2            147423   6m35.1s
    Printf                          |     1014                           1014     25.9s
    Profile                         |       86                             86     40.2s
    Downloads                       |      198     1      3               202   1m25.4s
    REPL                            |     1268     3              4      1275     47.0s
    Serialization                   |      119                    1       120     13.3s
    LinearAlgebra/triangular        |    37844                          37844  17m20.0s
    SuiteSparse_jll                 |        1                              1      0.1s
    SparseArrays/higherorderfns     |     7121                    1      7122   3m29.4s
    TOML                            |      415                    8       423     20.8s
    Tar                             |      280     2     17      11       310     19.1s
    floatfuncs                      |      232                            232   4m18.5s
    UUIDs                           |     1029                           1029      0.8s
    Random                          |   204290                         204290   1m33.5s
    Zlib_jll                        |        1                              1      0.1s
    dSFMT_jll                       |        1                              1      0.1s
    libLLVM_jll                     |        1                              1      0.0s
    libblastrampoline_jll           |        1                              1      0.0s
    nghttp2_jll                     |        1                              1      0.1s
    p7zip_jll                       |        1                              1      0.0s
    Unicode                         |      776                            776      7.0s
    cmdlineargs                     |      255                    3       258   4m46.1s
    Sockets                         |      170                    1       171   1m32.4s
    Test                            |      451                   18       469     51.1s
    Statistics                      |      801                            801   1m39.3s
    SHA                             |      107                            107   2m07.4s
    SuiteSparse                     |      921                            921   2m19.0s
    SparseArrays/sparsevector       |    10348                    4     10352   5m14.8s
    SparseArrays/sparse             |     4027                           4027   6m48.9s
    LinearAlgebra/addmul            |    10512                          10512  16m03.2s
    precompile                      |      123                            123     28.1s
    SharedArrays                    |      114                            114     23.1s
    threads                         |       10                    3        13   1m43.6s
    Distributed                     |       12                             12   2m43.3s
    stress                          |                                    None      0.0s
    FAILURE

The global RNG seed was 0x6a64a427756ccfb07ce8230fb96c5b80.
```

