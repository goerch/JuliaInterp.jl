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
Test Summary:      |     Pass  Fail  Error  Broken     Total     Time
  Overall          | 21465610    14      5  352561  21818190  9m28.2s
    unicode/utf8   |       19                             19     3.0s
    keywordargs    |      151                            151     7.6s
    worlds         |       88                             88     9.7s
    strings/io     |    12764                          12764    11.6s
    triplequote    |       29                             29     0.5s
    strings/search |      876                            876    12.2s
    char           |     1628                           1628     4.5s
    ambiguous      |      107                    2       109    17.6s
    intrinsics     |      301                            301     7.7s
    iobuffer       |      209                            209     3.3s
    strings/util   |     1147                           1147    24.4s
    core           |      643            1       1       645    26.7s
    staged         |       64                             64     7.2s
    strings/basic  |    87674                          87674    27.2s
    tuple          |      625                            625    16.1s
    atomics        |     3444                           3444    43.9s
    subtype        |   337674                   19    337693    52.7s
    dict           |   144420                         144420    52.7s
    intfuncs       |   227868                         227868    21.1s
    simdloop       |      240                            240     8.0s
    reduce         |     8580     2                     8582    47.0s
    vecelement     |      678                            678    21.1s
    hashing        |    12519                          12519  1m17.9s
    copy           |      533                            533    13.2s
    fastmath       |      946                            946    18.7s
    functional     |       98                             98    16.6s
    rational       |    98639                    1     98640    53.7s
    offsetarray    |      487                    3       490  1m41.6s
    ordering       |       37                             37     6.0s
    path           |     1051                   12      1063     2.6s
    operators      |    13040                          13040    15.9s
    parse          |    16098                          16098     9.3s
    numbers        |  1578756                    2   1578758  2m18.9s
    gmp            |     2357                           2357    13.3s
    reducedim      |      865                            865  2m06.4s
    backtrace      |       34     4              1        39     7.8s
    exceptions     |       70                             70     5.7s
    spawn          |      231     1              4       236    42.5s
    file           |        5            1                 6     3.8s
    version        |     2452                           2452     8.2s
    namedtuple     |      215                            215     7.8s
    math           |   148979                         148979  2m19.3s
    ccall          |     5352                           5352  1m49.4s
    mpfr           |     1135                    1      1136    40.2s
    complex        |     8432                    5      8437    29.9s
    arrayops       |     2031                    2      2033  4m00.5s
    abstractarray  |    55300                24795     80095  3m41.6s
    floatapprox    |       49                             49     4.4s
    regex          |      130                            130     4.8s
    sysinfo        |        4                              4     0.5s
    env            |       94                             94     1.8s
    reflection     |      415                            415    12.8s
    rounding       |   112720                         112720    10.4s
    strings/types  |  2302691                        2302691  4m43.2s
    combinatorics  |      170                            170    17.1s
    mod2pi         |       80                             80     1.8s
    client         |        5                              5     3.6s
    euler          |       12                             12     4.7s
    float16        |   762093                         762093    26.4s
    goto           |       19                             19     1.2s
    llvmcall       |       19                             19     1.3s
    llvmcall2      |        7                              7     0.3s
    ryu            |    31215                          31215     4.2s
    some           |       72                             72     2.3s
    errorshow      |      236     2                      238    17.3s
    meta           |       69                             69     4.9s
    stacktraces    |       46     2                       48     8.0s
    docs           |      238                            238    17.6s
    sets           |     3594                    1      3595    50.4s
    binaryplatforms |      341                            341    11.7s
    enums          |       99                             99     7.1s
    atexit         |       40                             40    14.7s
    show           |   128879                    8    128887  1m24.2s
    interpreter    |        3                              3     2.9s
    subarray       |   318316                         318316  6m11.0s
    int            |   524698                         524698    19.3s
    sorting        |    16096                   10     16106  3m51.0s
    bitset         |      195                            195     5.8s
    ranges         | 12110568               327682  12438250  1m40.2s
    error          |       31                             31     2.6s
    osutils        |       57                             57     0.8s
    checked        |     1239                           1239    18.8s
    iostream       |       50                             50     3.7s
    boundscheck    |                                    None    20.5s
    specificity    |      175                            175     1.3s
    cartesian      |      343                    3       346    18.0s
    secretbuffer   |       27                             27     2.3s
    read           |     3870                           3870  3m17.4s
    broadcast      |      511                            511  2m56.8s
    corelogging    |      231                            231     7.8s
    smallarrayshrink |       36                             36     1.4s
    opaque_closure |       37     2      3       1        43     4.9s
    channels       |      258                            258    31.3s
    filesystem     |        4                              4     0.5s
    syntax         |     1533                    1      1534    18.9s
    bitarray       |   912170                         912170  5m48.6s
    asyncmap       |      304                            304    20.0s
    reinterpretarray |      232                            232    27.8s
    missing        |      565                    1       566    31.9s
    download       |                                    None    24.2s
    iterators      |    10164                          10164  6m19.8s
    loading        |   158852     1                   158853  6m13.3s
    misc           |  1282197                        1282197  3m12.8s
    floatfuncs     |      232                            232  2m28.8s
    cmdlineargs    |      255                    3       258  3m37.5s
    precompile     |      123                            123    30.1s
    threads        |       10                    3        13  1m42.1s
    stress         |                                    None     0.0s
    FAILURE

  The global RNG seed was 0x268919098d475371d68f81015742566c.  
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
