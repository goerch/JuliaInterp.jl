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
  Overall                           | 38339676     9     27  352644  38692356  21m27.8s
    LinearAlgebra/schur             |      496                            496   1m06.1s
    LinearAlgebra/lapack            |      803                            803   1m41.8s
    LinearAlgebra/bunchkaufman      |     5688                           5688   1m49.0s
    LinearAlgebra/eigen             |      512                            512   2m16.4s
    LinearAlgebra/tridiag           |     1503                           1503   2m24.3s
    LinearAlgebra/svd               |      566                            566   2m43.3s
    LinearAlgebra/qr                |     4700                           4700   3m33.4s
    LinearAlgebra/generic           |      585                            585   1m15.0s
    LinearAlgebra/special           |     3171                           3171   4m10.2s
    LinearAlgebra/lq                |     2938                           2938   1m25.3s
    LinearAlgebra/cholesky          |     2474                           2474   3m19.3s
    LinearAlgebra/blas              |      756                            756   1m04.9s
    LinearAlgebra/pinv              |      292                            292     16.9s
    LinearAlgebra/lu                |     1294                           1294   3m30.7s
    LinearAlgebra/uniformscaling    |      591                            591   2m42.8s
    LinearAlgebra/givens            |     1847                           1847     11.7s
    LinearAlgebra/ldlt              |        8                              8      2.2s
    LinearAlgebra/factorization     |       80                   16        96      9.5s
    ambiguous                       |      107                    2       109     12.7s
    compiler/validation             |       28                             28      0.6s
    LinearAlgebra/hessenberg        |      604                   11       615   2m05.6s
    compiler/ssair                  |       40                             40      6.4s
    compiler/irpasses               |       51                    2        53      3.3s
    LinearAlgebra/bidiag            |     3706                           3706   5m49.6s
    LinearAlgebra/adjtrans          |      353                            353     52.7s
    compiler/inline                 |      101                            101      4.1s
    compiler/contextual             |       12                             12      3.5s
    strings/search                  |      876                            876     11.0s
    compiler/inference              |     1042                    2      1044     30.6s
    strings/basic                   |    87674                          87674     18.2s
    strings/io                      |    12764                          12764      7.0s
    unicode/utf8                    |       19                             19      0.3s
    compiler/codegen                |      164                            164     26.3s
    strings/types                   |  2302691                        2302691      6.4s
    worlds                          |       88                             88      3.3s
    keywordargs                     |      151                            151      3.1s
    strings/util                    |     1147                           1147     20.8s
    LinearAlgebra/structuredbroadcast |      670                            670   1m32.7s
    char                            |     1628                           1628      4.7s
    triplequote                     |       29                             29      0.1s
    atomics                         |     3444                           3444     39.4s
    intrinsics                      |      301                            301      5.6s
    subtype                         |   337674                   19    337693     47.4s
    iobuffer                        |      209                            209      3.3s
    staged                          |       64                             64      5.7s
    hashing                         |    12519                          12519     32.4s
    dict                            |   144420                         144420     45.7s
    LinearAlgebra/matmul            |     1106                           1106   7m42.4s
    tuple                           |      625                            625     12.4s
    reduce                          |     8582                           8582     40.6s
    numbers                         |  1578758                    2   1578760   2m07.6s
    core                            |  8445891                    3   8445894   2m18.8s
    simdloop                        |      240                            240      3.6s
    offsetarray                     |      487                    3       490   1m18.8s
    LinearAlgebra/dense             |     8475                           8475   8m41.0s
    intfuncs                        |   227947                         227947     16.0s
    copy                            |      533                            533      4.6s
    vecelement                      |      678                            678     16.0s
    fastmath                        |      946                            946     16.5s
    functional                      |       98                             98     11.8s
    rational                        |    98639                    1     98640     55.4s
    reducedim                       |      865                            865   1m49.1s
    ordering                        |       37                             37      4.9s
    math                            |   148979                         148979     59.6s
    operators                       |    13040                          13040     14.0s
    path                            |     1051                   12      1063      2.4s
    parse                           |    16098                          16098      7.6s
    gmp                             |     2357                           2357     10.6s
    LinearAlgebra/diagonal          |     2795                           2795   9m27.9s
    arrayops                        |     2031                    2      2033   3m17.3s
    backtrace                       |       38                    1        39     11.3s
    exceptions                      |       70                             70      1.9s
    file                            |        5            1                 6      4.0s
    spawn                           |      231     1              4       236     48.8s
    LinearAlgebra/symmetric         |     2835                           2835   9m10.3s
    version                         |     2452                           2452      2.0s
    namedtuple                      |      215                            215      5.6s
    abstractarray                   |    55164                24795     79959   3m27.0s
    subarray                        |   318316                         318316   5m59.6s
    floatapprox                     |       49                             49      2.1s
    ccall                           |     5352                           5352   2m15.5s
    reflection                      |      415                            415     11.5s
    regex                           |      130                            130      4.3s
    mpfr                            |     1135                    1      1136     42.2s
    sysinfo                         |        4                              4      0.4s
    env                             |       94                             94      1.3s
    float16                         |   762093                         762093     11.9s
    combinatorics                   |      170                            170     17.0s
    mod2pi                          |       80                             80      0.7s
    rounding                        |   112720                         112720     10.1s
    euler                           |       12                             12      2.0s
    client                          |        5                              5      3.5s
    complex                         |     8432                    5      8437     45.0s
    errorshow                       |      238                            238     11.9s
    goto                            |       19                             19      0.1s
    llvmcall                        |       19                             19      0.7s
    llvmcall2                       |        7                              7      0.1s
    ryu                             |    31215                          31215      3.4s
    some                            |       72                             72      2.0s
    meta                            |       69                             69      3.2s
    stacktraces                     |       48                             48      4.2s
    docs                            |      238                            238      7.7s
    sets                            |     3592                    1      3593     49.7s
    iterators                       |    10164                          10164   4m14.9s
    binaryplatforms                 |      341                            341     14.0s
    show                            |   128879                    8    128887   1m16.9s
    sorting                         |    16096                   10     16106   3m37.4s
    enums                           |       99                             99      8.7s
    misc                            |  1282225                        1282225     42.9s
    atexit                          |       40                             40     13.2s
    interpreter                     |        3                              3      3.1s
    ranges                          | 12110515               327682  12438197   1m36.9s
    bitset                          |      195                            195      5.4s
    read                            |     3725                           3725   2m33.4s
    error                           |       31                             31      2.1s
    osutils                         |       57                             57      0.2s
    broadcast                       |      511                            511   2m23.6s
    iostream                        |       50                             50      2.7s
    int                             |   524698                         524698     16.7s
    secretbuffer                    |       27                             27      2.1s
    specificity                     |      175                            175      0.4s
    checked                         |     1239                           1239     16.5s
    cartesian                       |      343                    3       346     15.2s
    boundscheck                     |                                    None     18.1s
    corelogging                     |      231                            231      7.7s
    smallarrayshrink                |       36                             36      0.9s
    opaque_closure                  |       41                    1        42      1.5s
    filesystem                      |        4                              4      0.3s
    syntax                          |     1533                    1      1534     13.9s
    reinterpretarray                |      232                            232     26.2s
    asyncmap                        |      304                            304     19.6s
    channels                        |      258                            258     35.1s
    bitarray                        |   915730                         915730   5m53.5s
    download                        |                                    None     24.4s
    missing                         |      565                    1       566     33.0s
    Dates/query                     |     1004                           1004      2.5s
    Dates/accessors                 |  7723858                        7723858     14.9s
    Dates/adjusters                 |     3149                           3149     11.3s
    Dates/rounding                  |      315                            315      4.0s
    Dates/types                     |      232                            232      3.3s
    Dates/periods                   |      955                            955     31.1s
    Dates/ranges                    |   350637                         350637     33.7s
    Dates/io                        |      331                            331     24.4s
    LibGit2/libgit2                 |      593     1                      594     52.0s
    Dates/conversions               |      160                            160      2.2s
    ArgTools                        |       34     1      4                39      5.8s
    Dates/arithmetic                |      385                            385     12.7s
    Base64                          |     2022                           2022      4.1s
    CompilerSupportLibraries_jll    |        4                              4      0.0s
    Artifacts                       |     1452                           1452     10.8s
    CRC32c                          |      664                            664      5.4s
    Future                          |                                    None      3.2s
    GMP_jll                         |        1                              1      0.2s
    DelimitedFiles                  |       89                             89      9.9s
    LLVMLibUnwind_jll               |                                    None      0.0s
    LazyArtifacts                   |        4                              4      4.2s
    LibCURL                         |        6                              6      1.4s
    LibCURL_jll                     |        1                              1      0.1s
    LibGit2_jll                     |        2                              2      0.1s
    LibSSH2_jll                     |                                    None      0.1s
    LibUV_jll                       |        1                              1      0.1s
    LibUnwind_jll                   |                                    None      0.0s
    Libdl                           |      131                    1       132      1.6s
    Logging                         |       40                             40      3.9s
    MPFR_jll                        |        1                              1      0.1s
    Markdown                        |      257                            257      9.0s
    MbedTLS_jll                     |        1                              1      0.1s
    Mmap                            |      138                            138     11.2s
    MozillaCACerts_jll              |        1                              1      0.0s
    FileWatching                    |      468                            468     39.8s
    OpenBLAS_jll                    |        1                              1      0.1s
    OpenLibm_jll                    |        1                              1      0.1s
    PCRE2_jll                       |        2                              2      0.1s
    NetworkOptions                  |     3518                           3518      2.0s
    InteractiveUtils                |      286                    1       287     37.5s
    Printf                          |     1014                           1014     26.2s
    Profile                         |       86                             86     36.3s
    Downloads                       |      198     1      3               202   1m26.7s
    REPL                            |     1268     3              4      1275     47.0s
    Serialization                   |      119                    1       120     17.3s
    LinearAlgebra/triangular        |    37844                          37844  17m37.7s
    loading                         |   165109            2            165111   7m50.4s
    SuiteSparse_jll                 |        1                              1      3.5s
    SparseArrays/higherorderfns     |     7121                    1      7122   3m38.0s
    TOML                            |      415                    8       423     21.2s
    Tar                             |      280     2     17      11       310     20.2s
    Random                          |   204290                         204290   1m37.8s
    UUIDs                           |     1029                           1029      0.5s
    Zlib_jll                        |        1                              1      3.6s
    dSFMT_jll                       |        1                              1      0.1s
    libLLVM_jll                     |        1                              1      0.1s
    libblastrampoline_jll           |        1                              1      0.1s
    nghttp2_jll                     |        1                              1      0.1s
    p7zip_jll                       |        1                              1      0.0s
    floatfuncs                      |      232                            232   4m39.2s
    Unicode                         |      776                            776      7.8s
    cmdlineargs                     |      255                    3       258   4m55.7s
    Sockets                         |      170                    1       171   1m32.7s
    Test                            |      451                   18       469     48.9s
    SHA                             |      107                            107   2m11.1s
    Statistics                      |      801                            801   1m40.6s
    SuiteSparse                     |      921                            921   2m00.7s
    SparseArrays/sparsevector       |    10348                    4     10352   5m19.4s
    LinearAlgebra/addmul            |     6786                           6786  16m00.9s
    SparseArrays/sparse             |     4027                           4027   6m58.1s
    precompile                      |      123                            123     27.8s
    SharedArrays                    |      114                            114     21.6s
    threads                         |       10                    3        13   1m44.1s
    Distributed                     |       12                             12   2m37.4s
    stress                          |                                    None      0.0s
    FAILURE

The global RNG seed was 0x64d5e4affe43e05f4b58bccd84e68074.
```

