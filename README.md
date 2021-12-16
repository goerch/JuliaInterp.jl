# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13

## Install

`Pkg.add("https://github.com/goerch/JuliaInterp.jl.git")`

## Run

Change directory to the root folder of the project, 
start Julia (using -t n for the desired number of threads) 
and execute

```
use Pkg
Pkg.activate(".")
include("test/runtests")
```

# Results

Julia 1.8.0-DEV on Windows:

```
Test Summary:                       |     Pass  Fail  Error  Broken     Total      Time
  Overall                           | 38352108     9     27  352644  38704788  21m34.2s
    LinearAlgebra/schur             |      496                            496   1m08.6s
    LinearAlgebra/lapack            |      803                            803   1m40.7s
    LinearAlgebra/bunchkaufman      |     5688                           5688   1m49.6s
    LinearAlgebra/eigen             |      512                            512   2m14.8s
    LinearAlgebra/tridiag           |     1503                           1503   2m20.7s
    LinearAlgebra/svd               |      566                            566   2m39.1s
    LinearAlgebra/qr                |     4700                           4700   3m28.1s
    LinearAlgebra/generic           |      585                            585   1m11.3s
    LinearAlgebra/special           |     3171                           3171   4m05.8s
    LinearAlgebra/lq                |     2938                           2938   1m25.8s
    LinearAlgebra/cholesky          |     2474                           2474   3m19.0s
    LinearAlgebra/blas              |      756                            756   1m03.7s
    LinearAlgebra/uniformscaling    |      591                            591   2m37.5s
    LinearAlgebra/pinv              |      292                            292     17.1s
    LinearAlgebra/lu                |     1294                           1294   3m30.2s
    LinearAlgebra/givens            |     1847                           1847     12.8s
    LinearAlgebra/ldlt              |        8                              8      2.8s
    LinearAlgebra/factorization     |       80                   16        96      8.9s
    ambiguous                       |      107                    2       109     10.7s
    compiler/validation             |       28                             28      0.6s
    LinearAlgebra/hessenberg        |      604                   11       615   2m06.8s
    compiler/ssair                  |       40                             40      5.9s
    compiler/irpasses               |       51                    2        53      3.2s
    LinearAlgebra/bidiag            |     3706                           3706   5m43.2s
    LinearAlgebra/adjtrans          |      353                            353     52.3s
    compiler/inline                 |      101                            101      4.1s
    compiler/contextual             |       12                             12      3.5s
    strings/search                  |      876                            876     10.4s
    compiler/inference              |     1042                    2      1044     28.3s
    strings/basic                   |    87674                          87674     17.6s
    strings/io                      |    12764                          12764      6.8s
    unicode/utf8                    |       19                             19      0.3s
    compiler/codegen                |      164                            164     28.9s
    strings/types                   |  2302691                        2302691      6.2s
    worlds                          |       88                             88      3.1s
    keywordargs                     |      151                            151      3.3s
    strings/util                    |     1147                           1147     20.4s
    LinearAlgebra/structuredbroadcast |      670                            670   1m27.0s
    atomics                         |     3444                           3444     36.9s
    triplequote                     |       29                             29      0.1s
    char                            |     1628                           1628      4.4s
    intrinsics                      |      301                            301      5.1s
    subtype                         |   337674                   19    337693     42.6s
    iobuffer                        |      209                            209      2.6s
    staged                          |       64                             64      5.2s
    hashing                         |    12519                          12519     28.5s
    dict                            |   144420                         144420     42.5s
    tuple                           |      625                            625     11.2s
    LinearAlgebra/matmul            |     1106                           1106   7m52.8s
    numbers                         |  1578758                    2   1578760   1m53.1s
    core                            |  8445891                    3   8445894   2m05.4s
    LinearAlgebra/dense             |     8475                           8475   8m14.2s
    reduce                          |     8582                           8582     33.4s
    offsetarray                     |      487                    3       490   1m09.1s
    simdloop                        |      240                            240      3.4s
    intfuncs                        |   227925                         227925     16.7s
    vecelement                      |      678                            678     15.3s
    copy                            |      533                            533      4.2s
    fastmath                        |      946                            946     14.8s
    functional                      |       98                             98     10.8s
    rational                        |    98639                    1     98640     49.7s
    operators                       |    13040                          13040     13.6s
    ordering                        |       37                             37      4.4s
    path                            |     1051                   12      1063      2.3s
    math                            |   148979                         148979     56.9s
    reducedim                       |      865                            865   1m40.4s
    parse                           |    16098                          16098      8.4s
    gmp                             |     2357                           2357     10.5s
    LinearAlgebra/diagonal          |     2795                           2795   8m53.4s
    arrayops                        |     2031                    2      2033   3m00.6s
    backtrace                       |       38                    1        39      6.8s
    exceptions                      |       70                             70      1.7s
    file                            |        5            1                 6      2.9s
    spawn                           |      231     1              4       236     47.4s
    LinearAlgebra/symmetric         |     2835                           2835   8m35.4s
    version                         |     2452                           2452      1.9s
    namedtuple                      |      215                            215      5.1s
    subarray                        |   318316                         318316   5m24.8s
    abstractarray                   |    55356                24795     80151   3m10.2s
    ccall                           |     5352                           5352   2m01.2s
    mpfr                            |     1135                    1      1136     34.9s
    floatapprox                     |       49                             49     14.2s
    regex                           |      130                            130      4.6s
    reflection                      |      415                            415      8.7s
    sysinfo                         |        4                              4      0.4s
    complex                         |     8432                    5      8437     27.0s
    env                             |       94                             94      1.2s
    float16                         |   762093                         762093     10.2s
    mod2pi                          |       80                             80      0.9s
    euler                           |       12                             12      2.0s
    rounding                        |   112720                         112720      9.8s
    client                          |        5                              5      3.6s
    combinatorics                   |      170                            170     16.7s
    errorshow                       |      238                            238     12.1s
    goto                            |       19                             19      0.1s
    llvmcall                        |       19                             19      0.8s
    llvmcall2                       |        7                              7      0.1s
    ryu                             |    31215                          31215      3.2s
    some                            |       72                             72      1.9s
    meta                            |       69                             69      3.4s
    stacktraces                     |       48                             48      4.1s
    docs                            |      238                            238      7.5s
    sets                            |     3592                    1      3593     45.4s
    binaryplatforms                 |      341                            341     11.2s
    iterators                       |    10164                          10164   3m57.2s
    show                            |   128879                    8    128887   1m13.9s
    enums                           |       99                             99      5.0s
    atexit                          |       40                             40     13.6s
    interpreter                     |        3                              3      2.6s
    ranges                          | 12110592               327682  12438274   1m28.4s
    sorting                         |    16096                   10     16106   3m21.8s
    misc                            |  1282212                        1282212     44.7s
    bitset                          |      195                            195      4.7s
    read                            |     3725                           3725   2m27.4s
    error                           |       31                             31      2.2s
    osutils                         |       57                             57      0.2s
    int                             |   524698                         524698     15.7s
    iostream                        |       50                             50      2.5s
    secretbuffer                    |       27                             27      2.3s
    specificity                     |      175                            175      0.3s
    checked                         |     1239                           1239     15.5s
    cartesian                       |      343                    3       346     13.1s
    boundscheck                     |                                    None     16.2s
    broadcast                       |      511                            511   2m28.6s
    corelogging                     |      231                            231      7.7s
    smallarrayshrink                |       36                             36      0.9s
    syntax                          |     1533                    1      1534     13.1s
    opaque_closure                  |       41                    1        42      1.5s
    filesystem                      |        4                              4      0.4s
    channels                        |      258                            258     28.3s
    bitarray                        |   913894                         913894   5m25.7s
    asyncmap                        |      304                            304     17.4s
    reinterpretarray                |      232                            232     24.2s
    missing                         |      565                    1       566     31.7s
    Dates/accessors                 |  7723858                        7723858     13.2s
    download                        |                                    None     24.3s
    Dates/query                     |     1004                           1004      2.1s
    Dates/adjusters                 |     3149                           3149     10.4s
    Dates/rounding                  |      315                            315      4.0s
    Dates/types                     |      232                            232      3.3s
    Dates/periods                   |      955                            955     29.6s
    Dates/ranges                    |   350637                         350637     32.4s
    LibGit2/libgit2                 |      593     1                      594     50.4s
    Dates/conversions               |      160                            160      1.9s
    Dates/io                        |      331                            331     22.8s
    Dates/arithmetic                |      385                            385     11.6s
    ArgTools                        |       34     1      4                39      5.7s
    Base64                          |     2022                           2022      4.5s
    CompilerSupportLibraries_jll    |        4                              4      0.1s
    CRC32c                          |      664                            664      4.8s
    Artifacts                       |     1452                           1452     10.1s
    Future                          |                                    None      2.9s
    GMP_jll                         |        1                              1      0.2s
    DelimitedFiles                  |       89                             89      9.5s
    LLVMLibUnwind_jll               |                                    None      0.0s
    LazyArtifacts                   |        4                              4      4.2s
    LibCURL                         |        6                              6      1.3s
    LibCURL_jll                     |        1                              1      0.1s
    LibGit2_jll                     |        2                              2      0.1s
    LibSSH2_jll                     |                                    None      0.1s
    LibUV_jll                       |        1                              1      0.1s
    LibUnwind_jll                   |                                    None      0.0s
    Libdl                           |      131                    1       132      1.6s
    Logging                         |       40                             40      3.7s
    MPFR_jll                        |        1                              1      0.1s
    Markdown                        |      257                            257      9.4s
    MbedTLS_jll                     |        1                              1      0.1s
    Mmap                            |      138                            138     10.2s
    MozillaCACerts_jll              |        1                              1      0.0s
    NetworkOptions                  |     3518                           3518      1.4s
    OpenBLAS_jll                    |        1                              1      0.1s
    OpenLibm_jll                    |        1                              1      0.1s
    PCRE2_jll                       |        2                              2      0.1s
    InteractiveUtils                |      286                    1       287     36.6s
    FileWatching                    |      468                            468     43.7s
    Printf                          |     1014                           1014     24.4s
    Profile                         |       86                             86     36.8s
    Downloads                       |      198     1      3               202   1m25.6s
    REPL                            |     1268     3              4      1275     43.9s
    LinearAlgebra/triangular        |    37844                          37844  16m32.3s
    Serialization                   |      119                    1       120     16.2s
    loading                         |   177469            2            177471   7m31.4s
    SparseArrays/higherorderfns     |     7121                    1      7122   3m30.0s
    SuiteSparse_jll                 |        1                              1      0.1s
    Random                          |   204290                         204290   1m30.1s
    TOML                            |      415                    8       423     19.9s
    UUIDs                           |     1029                           1029      0.7s
    floatfuncs                      |      232                            232   4m24.1s
    Zlib_jll                        |        1                              1      0.1s
    dSFMT_jll                       |        1                              1      0.1s
    libLLVM_jll                     |        1                              1      0.1s
    libblastrampoline_jll           |        1                              1      0.1s
    nghttp2_jll                     |        1                              1      0.1s
    p7zip_jll                       |        1                              1      0.0s
    Tar                             |      280     2     17      11       310     22.0s
    Unicode                         |      776                            776      7.4s
    cmdlineargs                     |      255                    3       258   4m40.9s
    Statistics                      |      801                            801   1m25.5s
    Sockets                         |      170                    1       171   1m31.8s
    Test                            |      451                   18       469     41.4s
    SHA                             |      107                            107   2m02.7s
    SuiteSparse                     |      921                            921   2m07.4s
    SparseArrays/sparsevector       |    10348                    4     10352   5m02.3s
    SparseArrays/sparse             |     4027                           4027   6m30.8s
    LinearAlgebra/addmul            |     8460                           8460  16m16.9s
    precompile                      |      123                            123     26.4s
    SharedArrays                    |      114                            114     20.1s
    threads                         |       10                    3        13   1m37.3s
    Distributed                     |       12                             12   2m31.9s
    stress                          |                                    None      0.0s
    FAILURE

The global RNG seed was 0x18b2661f32b6338cc6f19b790447472.
```

