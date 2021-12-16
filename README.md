# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. The interpreter processes IR thunks up to a maximal call stack depth or reaching `Core` and `Base` methods.

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
  Overall                           | 38329767     9     27  352644  38682447  26m34.7s
    LinearAlgebra/schur             |      496                            496   1m10.4s
    LinearAlgebra/lapack            |      803                            803   1m45.1s
    LinearAlgebra/bunchkaufman      |     5688                           5688   1m54.4s
    LinearAlgebra/eigen             |      512                            512   2m19.3s
    LinearAlgebra/tridiag           |     1503                           1503   2m27.1s
    LinearAlgebra/svd               |      566                            566   2m48.0s
    LinearAlgebra/qr                |     4700                           4700   3m37.3s
    LinearAlgebra/generic           |      585                            585   1m16.3s
    LinearAlgebra/special           |     3171                           3171   4m18.1s
    LinearAlgebra/lq                |     2938                           2938   1m37.6s
    LinearAlgebra/cholesky          |     2474                           2474   3m37.9s
    LinearAlgebra/blas              |      756                            756   1m10.2s
    LinearAlgebra/givens            |     1847                           1847     13.3s
    LinearAlgebra/pinv              |      292                            292     18.6s
    LinearAlgebra/uniformscaling    |      591                            591   2m56.9s
    LinearAlgebra/lu                |     1294                           1294   3m52.0s
    LinearAlgebra/ldlt              |        8                              8      2.5s
    LinearAlgebra/factorization     |       80                   16        96      8.7s
    ambiguous                       |      107                    2       109     12.0s
    compiler/validation             |       28                             28      0.6s
    LinearAlgebra/hessenberg        |      604                   11       615   2m23.4s
    compiler/ssair                  |       40                             40      7.7s
    compiler/irpasses               |       51                    2        53      4.1s
    LinearAlgebra/adjtrans          |      353                            353     58.3s
    LinearAlgebra/bidiag            |     3706                           3706   6m13.3s
    compiler/inline                 |      101                            101      4.6s
    compiler/contextual             |       12                             12      4.1s
    compiler/inference              |     1042                    2      1044     32.1s
    strings/search                  |      876                            876     13.1s
    strings/basic                   |    87674                          87674     19.2s
    compiler/codegen                |      164                            164     29.9s
    strings/io                      |    12764                          12764      7.5s
    unicode/utf8                    |       19                             19      0.3s
    worlds                          |       88                             88      3.6s
    strings/types                   |  2302691                        2302691      7.6s
    keywordargs                     |      151                            151      3.4s
    strings/util                    |     1147                           1147     23.5s
    LinearAlgebra/structuredbroadcast |      670                            670   1m36.3s
    atomics                         |     3444                           3444     40.6s
    char                            |     1628                           1628      4.5s
    triplequote                     |       29                             29      0.1s
    intrinsics                      |      301                            301      5.9s
    subtype                         |   337674                   19    337693     47.4s
    iobuffer                        |      209                            209      3.4s
    staged                          |       64                             64      4.9s
    hashing                         |    12519                          12519     32.9s
    dict                            |   144420                         144420     48.6s
    tuple                           |      625                            625     12.2s
    LinearAlgebra/matmul            |     1106                           1106   8m37.4s
    numbers                         |  1578758                    2   1578760   2m10.6s
    core                            |  8445891                    3   8445894   2m22.0s
    reduce                          |     8582                           8582     36.7s
    offsetarray                     |      487                    3       490   1m17.6s
    simdloop                        |      240                            240      4.4s
    LinearAlgebra/dense             |     8475                           8475   9m05.5s
    intfuncs                        |   227847                         227847     19.0s
    vecelement                      |      678                            678     17.0s
    copy                            |      533                            533      4.7s
    fastmath                        |      946                            946     17.7s
    functional                      |       98                             98     11.9s
    rational                        |    98639                    1     98640     56.1s
    operators                       |    13040                          13040     15.4s
    ordering                        |       37                             37      5.1s
    path                            |     1051                   12      1063      2.8s
    reducedim                       |      865                            865   1m52.4s
    parse                           |    16098                          16098      9.4s
    LinearAlgebra/diagonal          |     2795                           2795   9m57.1s
    math                            |   148979                         148979   1m56.9s
    gmp                             |     2357                           2357     12.4s
    arrayops                        |     2031                    2      2033   3m24.6s
    backtrace                       |       38                    1        39      5.0s
    exceptions                      |       70                             70      1.5s
    file                            |        5            1                 6      3.3s
    LinearAlgebra/symmetric         |     2835                           2835   9m37.2s
    version                         |     2452                           2452      2.1s
    spawn                           |      231     1              4       236     39.5s
    namedtuple                      |      215                            215      5.4s
    subarray                        |   318316                         318316   6m03.2s
    abstractarray                   |    55169                24795     79964   3m29.4s
    mpfr                            |     1135                    1      1136     37.9s
    floatapprox                     |       49                             49     19.3s
    complex                         |     8432                    5      8437     31.0s
    regex                           |      130                            130      5.6s
    ccall                           |     5352                           5352   2m27.4s
    sysinfo                         |        4                              4      0.4s
    env                             |       94                             94      1.6s
    reflection                      |      415                            415     14.2s
    float16                         |   762093                         762093     12.1s
    mod2pi                          |       80                             80      1.1s
    euler                           |       12                             12      2.6s
    rounding                        |   112720                         112720     10.5s
    client                          |        5                              5      4.3s
    combinatorics                   |      170                            170     18.8s
    errorshow                       |      238                            238     11.9s
    goto                            |       19                             19      0.1s
    llvmcall                        |       19                             19      0.9s
    llvmcall2                       |        7                              7      0.1s
    ryu                             |    31215                          31215      3.5s
    some                            |       72                             72      2.4s
    meta                            |       69                             69      3.8s
    stacktraces                     |       48                             48      5.6s
    docs                            |      238                            238      9.7s
    sets                            |     3592                    1      3593     53.5s
    iterators                       |    10164                          10164   4m14.7s
    binaryplatforms                 |      341                            341     15.0s
    show                            |   128879                    8    128887   1m18.6s
    atexit                          |       40                             40     15.9s
    enums                           |       99                             99      8.5s
    interpreter                     |        3                              3      3.1s
    misc                            |  1282229                        1282229     49.5s
    ranges                          | 12110583               327682  12438265   1m44.7s
    bitset                          |      195                            195      5.9s
    int                             |   524698                         524698     18.5s
    read                            |     3725                           3725   2m57.1s
    error                           |       31                             31      2.6s
    osutils                         |       57                             57      0.3s
    checked                         |     1239                           1239     17.6s
    iostream                        |       50                             50      3.1s
    secretbuffer                    |       27                             27      2.4s
    specificity                     |      175                            175      0.3s
    broadcast                       |      511                            511   2m49.7s
    cartesian                       |      343                    3       346     15.7s
    boundscheck                     |                                    None     18.5s
    sorting                         |    16096                   10     16106   3m45.0s
    corelogging                     |      231                            231      9.1s
    smallarrayshrink                |       36                             36      1.5s
    opaque_closure                  |       41                    1        42      2.1s
    filesystem                      |        4                              4      0.4s
    bitarray                        |   913650                         913650   6m07.7s
    syntax                          |     1533                    1      1534     15.7s
    reinterpretarray                |      232                            232     27.0s
    channels                        |      258                            258     36.3s
    asyncmap                        |      304                            304     21.5s
    missing                         |      565                    1       566     34.7s
    download                        |                                    None     24.5s
    Dates/query                     |     1004                           1004      2.5s
    Dates/accessors                 |  7723858                        7723858     14.4s
    Dates/adjusters                 |     3149                           3149     12.1s
    Dates/rounding                  |      315                            315      4.3s
    Dates/types                     |      232                            232      3.8s
    Dates/periods                   |      955                            955     33.5s
    Dates/ranges                    |   350637                         350637     35.2s
    Dates/conversions               |      160                            160      2.2s
    LibGit2/libgit2                 |      593     1                      594     57.0s
    Dates/io                        |      331                            331     25.6s
    ArgTools                        |       34     1      4                39      6.1s
    Dates/arithmetic                |      385                            385     12.3s
    Base64                          |     2022                           2022      4.6s
    CompilerSupportLibraries_jll    |        4                              4      0.0s
    CRC32c                          |      664                            664      5.1s
    Artifacts                       |     1452                           1452     10.8s
    Future                          |                                    None      3.4s
    GMP_jll                         |        1                              1      0.2s
    DelimitedFiles                  |       89                             89     10.5s
    LLVMLibUnwind_jll               |                                    None      0.0s
    LazyArtifacts                   |        4                              4      4.4s
    LibCURL                         |        6                              6      1.4s
    LibCURL_jll                     |        1                              1      0.1s
    LibGit2_jll                     |        2                              2      0.1s
    LibSSH2_jll                     |                                    None      0.1s
    LibUV_jll                       |        1                              1      0.1s
    LibUnwind_jll                   |                                    None      0.0s
    Libdl                           |      131                    1       132      1.5s
    Logging                         |       40                             40      4.4s
    MPFR_jll                        |        1                              1      0.1s
    Markdown                        |      257                            257      8.9s
    MbedTLS_jll                     |        1                              1      0.1s
    Mmap                            |      138                            138     11.3s
    MozillaCACerts_jll              |        1                              1      0.0s
    NetworkOptions                  |     3518                           3518      1.6s
    OpenBLAS_jll                    |        1                              1      0.1s
    OpenLibm_jll                    |        1                              1      0.1s
    PCRE2_jll                       |        2                              2      0.1s
    InteractiveUtils                |      286                    1       287     38.6s
    FileWatching                    |      468                            468     43.5s
    Printf                          |     1014                           1014     26.8s
    Profile                         |       86                             86     37.6s
    Downloads                       |      198     1      3               202   1m27.8s
    REPL                            |     1268     3              4      1275     47.3s
    loading                         |   153487            2            153489   7m28.5s
    LinearAlgebra/triangular        |    37844                          37844  18m18.5s
    Serialization                   |      119                    1       120     17.6s
    SuiteSparse_jll                 |        1                              1      0.1s
    TOML                            |      415                    8       423     21.8s
    Tar                             |      280     2     17      11       310     20.9s
    SparseArrays/higherorderfns     |     7121                    1      7122   4m04.3s
    UUIDs                           |     1029                           1029      0.9s
    Random                          |   204290                         204290   1m39.1s
    Zlib_jll                        |        1                              1      0.1s
    dSFMT_jll                       |        1                              1      0.1s
    libLLVM_jll                     |        1                              1      0.0s
    libblastrampoline_jll           |        1                              1      0.0s
    nghttp2_jll                     |        1                              1      0.1s
    p7zip_jll                       |        1                              1      0.0s
    floatfuncs                      |      232                            232   4m42.3s
    Unicode                         |      776                            776      8.7s
    cmdlineargs                     |      255                    3       258   5m13.4s
    Sockets                         |      170                    1       171   1m32.6s
    Statistics                      |      801                            801   1m38.1s
    SHA                             |      107                            107   2m11.5s
    Test                            |      451                   18       469     52.3s
    SuiteSparse                     |      921                            921   2m28.8s
    SparseArrays/sparsevector       |    10348                    4     10352   5m34.5s
    SparseArrays/sparse             |     4027                           4027   7m11.7s
    LinearAlgebra/addmul            |    10602                          10602  20m52.5s
    precompile                      |      123                            123     29.3s
    SharedArrays                    |      114                            114     24.9s
    threads                         |       10                    3        13   1m46.7s
    Distributed                     |       12                             12   2m48.0s
    stress                          |                                    None      0.0s
    FAILURE

The global RNG seed was 0x933c3464e8ddd8c15a4d23c5d34ad31.
```

