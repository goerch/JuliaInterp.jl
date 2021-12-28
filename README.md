# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. 
The interpreter processes IR thunks until reaching a time budget per call site or `Core` methods. 
It switches to calling compiled methods then.

## Installation

Clone the repository from GitHub.

## Running

Change directory to the test folder of the project and execute

```
julia.exe -t5 runtests.jl --skip compiler stdlib
```

## Results

All test were run with a time budget of 10 ns per call site.

### Julia 1.6.5 on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total
  Overall          | 21929207    14      2  352564  22281787
    unicode/utf8   |       19                             19
    strings/io     |    12751                          12751
    keywordargs    |      151                            151
    triplequote    |       29                             29
    intrinsics     |       90                             90
    strings/search |      692                            692
    strings/util   |      461                            461
    worlds         |       83                             83
    char           |     1529                           1529
    iobuffer       |      204                            204
    staged         |       64                             64
    tuple          |      578                            578
    ambiguous      |      101                    2       103
    strings/basic  |    87674                          87674
    hashing        |    12356                          12356
    dict           |   144409                         144409
    reduce         |     8543     2                     8545
    subtype        |   337653                   16    337669
    simdloop       |      249                            249
    intfuncs       |   215864                         215864
    copy           |      532                            532
    core           |      613            1       1       615
    reducedim      |      817                            817
    offsetarray    |      477                    3       480
    rational       |    98622                    1     98623
    fastmath       |      934                            934
    functional     |       95                             95
    operators      |    12949                          12949
    path           |     1015                   12      1027
    vecelement     |      678                            678
    ordering       |       35                             35
    numbers        |  1578565                    1   1578566
    parse          |    16098                          16098
    gmp            |     2315                           2315
    backtrace      |       31     4              1        36
    exceptions     |       70                             70
    abstractarray  |    55170                24795     79965
    file           |        5            1                 6
    spawn          |      200                    4       204
    math           |  1520143                        1520143
    namedtuple     |      194                    1       195
    version        |     2452                           2452
    arrayops       |     1979                    2      1981
    floatapprox    |       49                             49
    mpfr           |     1135                           1135
    regex          |      114                            114
    complex        |     8429                    5      8434
    float16        |      235                            235
    sysinfo        |        4                              4
    reflection     |      403                            403
    combinatorics  |      170                            170
    env            |       96                             96
    ccall          |     5332                           5332
    mod2pi         |       80                             80
    euler          |       12                             12
    client         |        3                              3
    rounding       |   112720                         112720
    errorshow      |      215     2                      217
    goto           |       19                             19
    llvmcall       |       19                             19
    llvmcall2      |        7                              7
    ryu            |    31215                          31215
    some           |       65                             65
    meta           |       64                             64
    sets           |     3518                    1      3519
    stacktraces    |       44     4                       48
    docs           |      227                            227
    iterators      |    10071                          10071
    atexit         |       40                             40
    binaryplatforms |      341                            341
    show           |     1520                    8      1528
    ranges         | 12109686               327693  12437379
    enums          |       99                             99
    interpreter    |        3                              3
    bitset         |      195                            195
    read           |     3141                           3141
    sorting        |    12709                   10     12719
    int            |   524668                         524668
    error          |       31                             31
    osutils        |       56                             56
    checked        |     1239                           1239
    iostream       |       50                             50
    boundscheck    |                                No tests
    secretbuffer   |       27                             27
    specificity    |      175                            175
    cartesian      |      234                    3       237
    broadcast      |      480                            480
    corelogging    |      231                            231
    bitarray       |   914114                         914114
    smallarrayshrink |       36                             36
    filesystem     |        3     1                        4
    subarray       |   318299                         318299
    syntax         |     1408                    1      1409
    channels       |      237                            237
    asyncmap       |      292                            292
    missing        |      472                    1       473
    reinterpretarray |      226                            226
    download       |                                No tests
    floatfuncs     |      193                            193
    loading        |   162089     1                   162090
    cmdlineargs    |      238                    3       241
    misc           |  1282132                        1282132
    strings/types  |  2302691                        2302691
    precompile     |      116                            116
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0xba14f4d65117b1bf81e2f888dea997c2.
```

### Julia 1.7.1 on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total
  Overall          | 21437715    21      5  352557  21790298
    unicode/utf8   |       19                             19
    keywordargs    |      151                            151
    strings/io     |    12764                          12764
    strings/search |      692                            692
    worlds         |       83                             83
    triplequote    |       29                             29
    char           |     1623                           1623
    intrinsics     |      301                            301
    ambiguous      |      106                    2       108
    strings/util   |      619                            619
    iobuffer       |      205                            205
    staged         |       64                             64
    core           |      611            1       1       613
    strings/basic  |    87674                          87674
    tuple          |      606                            606
    atomics        |     3444                           3444
    subtype        |   337674                   19    337693
    dict           |   144420                         144420
    intfuncs       |   215864                         215864
    simdloop       |      240                            240
    reduce         |     8578     2                     8580
    copy           |      533                            533
    vecelement     |      678                            678
    hashing        |    12519                          12519
    rational       |    98634                    1     98635
    fastmath       |      946                            946
    functional     |       98                             98
    ordering       |       35                             35
    offsetarray    |      485                    3       488
    path           |     1051                   12      1063
    operators      |    13039                          13039
    parse          |    16098                          16098
    numbers        |  1578627                    1   1578628
    reducedim      |      865                            865
    gmp            |     2324                           2324
    backtrace      |       34     4              1        39
    exceptions     |       70                             70
    file           |        5            1                 6
    math           |   148810                         148810
    version        |     2452                           2452
    spawn          |      210     1              4       215
    namedtuple     |      214                            214
    arrayops       |     2013                    2      2015
    mpfr           |     1127                    1      1128
    ccall          |     5351                           5351
    floatapprox    |       49                             49
    abstractarray  |    55144                24795     79939
    regex          |      130                            130
    reflection     |      411                            411
    sysinfo        |        4                              4
    env            |       96                             96
    complex        |     8432                    5      8437
    combinatorics  |      170                            170
    mod2pi         |       80                             80
    float16        |   762091                         762091
    euler          |       12                             12
    rounding       |   112720                         112720
    client         |        4                              4
    errorshow      |      219     3                      222
    goto           |       19                             19
    llvmcall       |       19                             19
    llvmcall2      |        7                              7
    ryu            |    31215                          31215
    some           |       71                             71
    meta           |       69                             69
    strings/types  |  2302691                        2302691
    sets           |     3529                    1      3530
    stacktraces    |       39     9                       48
    docs           |      236                            236
    sorting        |    12709                   10     12719
    binaryplatforms |      341                            341
    enums          |       99                             99
    read           |     3725                           3725
    atexit         |       40                             40
    interpreter    |        3                              3
    int            |   524693                         524693
    bitset         |      195                            195
    ranges         | 12110538               327682  12438220
    show           |   128869                    8    128877
    error          |       31                             31
    subarray       |   318299                         318299
    checked        |     1239                           1239
    osutils        |       57                             57
    secretbuffer   |       27                             27
    specificity    |      175                            175
    iostream       |       50                             50
    broadcast      |      508                            508
    cartesian      |      238                    3       241
    boundscheck    |                                No tests
    corelogging    |      231                            231
    smallarrayshrink |       36                             36
    bitarray       |   913150                         913150
    filesystem     |        4                              4
    opaque_closure |       37     1      3       1        42
    syntax         |     1509                    1      1510
    channels       |      244                            244
    asyncmap       |      304                            304
    reinterpretarray |      232                            232
    missing        |      565                    1       566
    download       |                                No tests
    iterators      |    10080                          10080
    loading        |   147285     1                   147286
    floatfuncs     |      221                            221
    misc           |  1282179                        1282179
    cmdlineargs    |      242                    3       245
    precompile     |      117                            117
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0xaa9d3a124fe760bc6015d70ceabafb74.
```

### Julia 1.8.0-DEV on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total      Time
  Overall          | 21474888    19      5  352561  21827473  10m12.8s
    unicode/utf8   |       19                             19      2.9s
    keywordargs    |      151                            151      7.2s
    strings/io     |    12764                          12764      9.9s
    worlds         |       87     1                       88     10.5s
    strings/search |      876                            876     11.5s
    triplequote    |       29                             29      0.2s
    char           |     1628                           1628      4.7s
    ambiguous      |      107                    2       109     17.3s
    intrinsics     |      301                            301      6.9s
    strings/util   |     1147                           1147     23.4s
    staged         |       64                             64      7.6s
    strings/basic  |    87674                          87674     27.6s
    iobuffer       |      209                            209      9.1s
    tuple          |      625                            625     13.4s
    atomics        |     3444                           3444     42.0s
    dict           |   144420                         144420     47.7s
    reduce         |     8580     2                     8582     45.8s
    intfuncs       |   227814                         227814     18.1s
    hashing        |    12519                          12519   1m09.2s
    simdloop       |      240                            240      6.2s
    vecelement     |      678                            678     23.5s
    copy           |      533                            533      6.1s
    offsetarray    |      487                    3       490   1m45.1s
    numbers        |  1578756                    2   1578758   2m10.4s
    rational       |    98639                    1     98640     50.8s
    fastmath       |      946                            946     16.2s
    functional     |       98                             98     14.4s
    reducedim      |      865                            865   1m48.9s
    path           |     1051                   12      1063      2.2s
    ordering       |       37                             37      5.4s
    operators      |    13040                          13040     13.8s
    parse          |    16098                          16098      7.7s
    gmp            |     2357                           2357     10.4s
    math           |   148979                         148979   2m04.5s
    arrayops       |     2031                    2      2033   3m32.3s
    backtrace      |       34     4              1        39      6.4s
    abstractarray  |    55177                24795     79972   3m23.1s
    core           |      643            1       1       645   4m08.7s
    exceptions     |       70                             70     14.1s
    file           |        5            1                 6      8.6s
    version        |     2452                           2452      2.6s
    ccall          |     5352                           5352   1m54.3s
    namedtuple     |      215                            215      7.0s
    spawn          |      231     1              4       236     41.3s
    floatapprox    |       49                             49      6.6s
    complex        |     8432                    5      8437     29.8s
    mpfr           |     1135                    1      1136     34.8s
    regex          |      130                            130      4.6s
    reflection     |      415                            415     17.5s
    sysinfo        |        4                              4      0.4s
    env            |       94                             94      1.1s
    float16        |   762093                         762093     10.2s
    combinatorics  |      170                            170     15.8s
    mod2pi         |       80                             80      1.0s
    rounding       |   112720                         112720      9.5s
    euler          |       12                             12      2.6s
    client         |        5                              5      4.5s
    subarray       |   318316                         318316   5m34.9s
    errorshow      |      236     2                      238     17.6s
    goto           |       19                             19      5.4s
    llvmcall       |       19                             19      1.5s
    llvmcall2      |        7                              7      0.4s
    ryu            |    31215                          31215      3.4s
    some           |       72                             72      2.3s
    meta           |       69                             69      6.3s
    sorting        |    16096                   10     16106   3m28.1s
    stacktraces    |       42     6                       48      9.8s
    sets           |     3594                    1      3595     47.2s
    iterators      |    10164                          10164   4m05.8s
    docs           |      238                            238     11.3s
    binaryplatforms |      341                            341     12.0s
    show           |   128879                    8    128887   1m15.5s
    enums          |       99                             99      5.0s
    interpreter    |        3                              3      3.2s
    bitarray       |   915738                         915738   5m15.9s
    ranges         | 12110594               327682  12438276   1m32.8s
    bitset         |      195                            195      5.3s
    atexit         |       40                             40     20.2s
    error          |       31                             31      2.6s
    int            |   524698                         524698     18.1s
    osutils        |       57                             57      1.1s
    checked        |     1239                           1239     16.9s
    iostream       |       50                             50      2.9s
    secretbuffer   |       27                             27      1.6s
    specificity    |      175                            175      1.3s
    boundscheck    |                                    None     17.7s
    cartesian      |      343                    3       346     16.7s
    corelogging    |      231                            231      7.0s
    broadcast      |      511                            511   2m52.2s
    channels       |      258                            258     27.2s
    smallarrayshrink |       36                             36      0.9s
    syntax         |     1533                    1      1534     20.0s
    filesystem     |        4                              4      0.4s
    opaque_closure |       37     2      3       1        43      5.4s
    reinterpretarray |      232                            232     33.0s
    read           |     3870                           3870   3m18.2s
    asyncmap       |      304                            304     18.1s
    missing        |      565                    1       566     29.5s
    download       |                                    None     24.3s
    loading        |   164714     1                   164715   6m06.4s
    floatfuncs     |      232                            232   2m52.9s
    misc           |  1282201                        1282201   3m47.5s
    strings/types  |  2302691                        2302691  10m11.0s
    subtype        |   337674                   19    337693  10m04.8s
    cmdlineargs    |      255                    3       258   3m37.2s
    precompile     |      123                            123     29.0s
    threads        |       10                    3        13   1m38.9s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0xa26b884b2f014398f0f81eb4962268f0.
```

## Bonus

Towers of interpretation:

```
using JuliaInterp
JuliaInterp.interpret_ast(Main, Meta.parse("1 + 1"), true, UInt64(1000000))
```

yields

```
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
:interpret_lower = :interpret_lower
expr = :(1 + 1)
:interpret_lower = :interpret_lower
T = :call
args = Any[:+, 1, 1]
codestate.pc = 2
codestate.src.code[codestate.pc] = :(return %1)
:interpret_lower = :interpret_lower
returnnode = :(return %1)
ans = Some(2)
ans = 2
2
```

and

```
using JuliaInterp
JuliaInterp.interpret_ast(Main, Meta.parse("using JuliaInterp; JuliaInterp.interpret_ast(Main, Meta.parse(\"1 + 1\"), false, UInt64(1000000))"), true, UInt64(1000000))
```

yields

```
:toplevel = :toplevel
args = Any[:(using JuliaInterp), :(JuliaInterp.interpret_ast(Main, Meta.parse("1 + 1"), false, UInt64(1000000)))]
:using = :using
args = Any[:($(Expr(:., :JuliaInterp)))]
:eval_lower_ast = :eval_lower_ast
expr = :(using JuliaInterp)
ans = nothing
:call = :call
args = Any[:(JuliaInterp.interpret_ast), :Main, :(Meta.parse("1 + 1")), false, :(UInt64(1000000))]
:eval_lower_ast = :eval_lower_ast
expr = :(JuliaInterp.interpret_ast(Main, Meta.parse("1 + 1"), false, UInt64(1000000)))
codestate.src = CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = Base.getproperty(JuliaInterp, :interpret_ast)
│   %2 = Base.getproperty(Meta, :parse)
│   %3 = (%2)("1 + 1")
│   %4 = UInt64(1000000)
│   %5 = (%1)(Main, %3, false, %4)
└──      return %5
)
codestate.pc = 1
codestate.src.code[codestate.pc] = :(Base.getproperty(JuliaInterp, :interpret_ast))
:interpret_lower = :interpret_lower
expr = :(Base.getproperty(JuliaInterp, :interpret_ast))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(Base.getproperty), :JuliaInterp, :(:interpret_ast)]
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(Meta, :parse))
:interpret_lower = :interpret_lower
expr = :(Base.getproperty(Meta, :parse))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(Base.getproperty), :Meta, :(:parse)]
codestate.pc = 3
codestate.src.code[codestate.pc] = :((%2)("1 + 1"))
:interpret_lower = :interpret_lower
expr = :((%2)("1 + 1"))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(%2), "1 + 1"]
codestate.pc = 4
codestate.src.code[codestate.pc] = :(UInt64(1000000))
:interpret_lower = :interpret_lower
expr = :(UInt64(1000000))
:interpret_lower = :interpret_lower
T = :call
args = Any[:UInt64, 1000000]
codestate.pc = 5
codestate.src.code[codestate.pc] = :((%1)(Main, %3, false, %4))
:interpret_lower = :interpret_lower
expr = :((%1)(Main, %3, false, %4))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(%1), :Main, :(%3), false, :(%4)]
codestate.pc = 6
codestate.src.code[codestate.pc] = :(return %5)
:interpret_lower = :interpret_lower
returnnode = :(return %5)
ans = Some(2)
ans = 2
2
```
