# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. 
The interpreter processes IR thunks until reaching a time budget per call site or `Core` or `Base` methods. 
It switches to calling compiled methods then.

## Installation

Clone the repository from GitHub.

## Running

Change directory to the test folder of the project and execute

```
julia.exe -t5 runtests.jl --skip llvmcall compiler stdlib
```

## Results

All test were run with a time budget of 10 ns per call site.

### Julia 1.6.5 on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total
  Overall          | 21920715    10      2  352564  22273291
    unicode/utf8   |       19                             19
    strings/io     |    12751                          12751
    keywordargs    |      151                            151
    triplequote    |       29                             29
    strings/search |      692                            692
    intrinsics     |       90                             90
    worlds         |       82     1                       83
    strings/util   |      461                            461
    char           |     1529                           1529
    iobuffer       |      204                            204
    staged         |       64                             64
    core           |      613            1       1       615
    ambiguous      |      101                    2       103
    strings/basic  |    87674                          87674
    tuple          |      578                            578
    hashing        |    12356                          12356
    intfuncs       |   215864                         215864
    simdloop       |      249                            249
    dict           |   144409                         144409
    reduce         |     8543     2                     8545
    vecelement     |      678                            678
    copy           |      532                            532
    fastmath       |      934                            934
    subtype        |   337653                   16    337669
    offsetarray    |      477                    3       480
    functional     |       95                             95
    operators      |    12949                          12949
    ordering       |       35                             35
    path           |     1015                   12      1027
    rational       |    98622                    1     98623
    reducedim      |      817                            817
    parse          |    16098                          16098
    gmp            |     2315                           2315
    numbers        |  1578565                    1   1578566
    backtrace      |       31     4              1        36
    spawn          |      200                    4       204
    exceptions     |       70                             70
    file           |        5            1                 6
    version        |     2452                           2452
    namedtuple     |      194                    1       195
    abstractarray  |    54784                24795     79579
    math           |  1520143                        1520143
    ccall          |     5332                           5332
    floatapprox    |       49                             49
    reflection     |      403                            403
    regex          |      114                            114
    float16        |      235                            235
    mpfr           |     1135                           1135
    complex        |     8429                    5      8434
    sysinfo        |        4                              4
    env            |       96                             96
    combinatorics  |      170                            170
    mod2pi         |       80                             80
    arrayops       |     1979                    2      1981
    euler          |       12                             12
    client         |        3                              3
    rounding       |   112720                         112720
    errorshow      |      217                            217
    goto           |       19                             19
    llvmcall       |       19                             19
    llvmcall2      |        7                              7
    ryu            |    31215                          31215
    some           |       65                             65
    meta           |       64                             64
    stacktraces    |       48                             48
    docs           |      227                            227
    sets           |     3518                    1      3519
    strings/types  |  2302691                        2302691
    iterators      |    10071                          10071
    enums          |       99                             99
    binaryplatforms |      341                            341
    atexit         |       40                             40
    interpreter    |        3                              3
    misc           |  1282136                        1282136
    bitset         |      195                            195
    read           |     3141                           3141
    show           |     1520                    8      1528
    int            |   524668                         524668
    ranges         | 12109734               327693  12437427
    osutils        |       56                             56
    error          |       31                             31
    iostream       |       50                             50
    secretbuffer   |       27                             27
    checked        |     1239                           1239
    specificity    |      175                            175
    boundscheck    |                                No tests
    cartesian      |      234                    3       237
    corelogging    |      231                            231
    syntax         |     1407     1              1      1409
    sorting        |    12709                   10     12719
    smallarrayshrink |       36                             36
    filesystem     |        3     1                        4
    broadcast      |      480                            480
    channels       |      237                            237
    reinterpretarray |      226                            226
    asyncmap       |      292                            292
    missing        |      472                    1       473
    bitarray       |   913122                         913122
    subarray       |   318299                         318299
    download       |                                No tests
    loading        |   154919     1                   154920
    floatfuncs     |      193                            193
    cmdlineargs    |      238                    3       241
    precompile     |      116                            116
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0x44392a72f6287afdc132e565d35ce960.
```

### Julia 1.7.5 on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total
  Overall          | 21455057    13      5  352557  21807632
    unicode/utf8   |       19                             19
    keywordargs    |      151                            151
    strings/search |      692                            692
    strings/io     |    12764                          12764
    triplequote    |       29                             29
    worlds         |       83                             83
    char           |     1623                           1623
    ambiguous      |      106                    2       108
    intrinsics     |      301                            301
    strings/util   |      619                            619
    iobuffer       |      205                            205
    staged         |       64                             64
    strings/basic  |    87674                          87674
    tuple          |      606                            606
    atomics        |     3444                           3444
    hashing        |    12519                          12519
    dict           |   144420                         144420
    simdloop       |      240                            240
    reduce         |     8578     2                     8580
    intfuncs       |   215864                         215864
    subtype        |   337674                   19    337693
    copy           |      533                            533
    vecelement     |      678                            678
    core           |      611            1       1       613
    fastmath       |      946                            946
    offsetarray    |      485                    3       488
    functional     |       98                             98
    ordering       |       35                             35
    path           |     1051                   12      1063
    numbers        |  1578627                    1   1578628
    rational       |    98634                    1     98635
    operators      |    13039                          13039
    parse          |    16098                          16098
    gmp            |     2324                           2324
    reducedim      |      865                            865
    backtrace      |       34     4              1        39
    exceptions     |       70                             70
    file           |        5            1                 6
    spawn          |      210     1              4       215
    math           |   148810                         148810
    version        |     2452                           2452
    namedtuple     |      214                            214
    mpfr           |     1127                    1      1128
    arrayops       |     2013                    2      2015
    floatapprox    |       49                             49
    ccall          |     5351                           5351
    regex          |      130                            130
    reflection     |      411                            411
    complex        |     8432                    5      8437
    sysinfo        |        4                              4
    abstractarray  |    55133                24795     79928
    env            |       96                             96
    float16        |   762091                         762091
    mod2pi         |       80                             80
    euler          |       12                             12
    combinatorics  |      170                            170
    client         |        4                              4
    rounding       |   112720                         112720
    errorshow      |      219     3                      222
    strings/types  |  2302691                        2302691
    goto           |       19                             19
    llvmcall2      |        7                              7
    llvmcall       |       19                             19
    ryu            |    31215                          31215
    some           |       71                             71
    meta           |       69                             69
    stacktraces    |       48                             48
    docs           |      236                            236
    binaryplatforms |      341                            341
    sets           |     3529                    1      3530
    enums          |       99                             99
    read           |     3725                           3725
    atexit         |       40                             40
    interpreter    |        3                              3
    show           |   128869                    8    128877
    misc           |  1282166                        1282166
    bitset         |      195                            195
    sorting        |    12709                   10     12719
    broadcast      |      508                            508
    error          |       31                             31
    ranges         | 12110574               327682  12438256
    osutils        |       57                             57
    iostream       |       50                             50
    secretbuffer   |       27                             27
    int            |   524693                         524693
    specificity    |      175                            175
    checked        |     1239                           1239
    cartesian      |      238                    3       241
    boundscheck    |                                No tests
    corelogging    |      231                            231
    smallarrayshrink |       36                             36
    opaque_closure |       37     1      3       1        42
    syntax         |     1508     1              1      1510
    iterators      |    10080                          10080
    filesystem     |        4                              4
    channels       |      244                            244
    subarray       |   318299                         318299
    reinterpretarray |      232                            232
    asyncmap       |      304                            304
    missing        |      565                    1       566
    bitarray       |   916366                         916366
    download       |                                No tests
    loading        |   161391     1                   161392
    floatfuncs     |      221                            221
    cmdlineargs    |      242                    3       245
    precompile     |      117                            117
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0x806710cff2ab20fbba9977deb6ac6d4c.
```

### Julia 1.8.0-DEV on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total     Time
  Overall          | 21474485    19      7  352561  21827072  8m28.2s
    unicode/utf8   |       19                             19     3.0s
    keywordargs    |      151                            151     7.2s
    strings/io     |    12764                          12764     9.8s
    worlds         |       87     1                       88    10.7s
    strings/search |      876                            876    11.2s
    triplequote    |       29                             29     0.3s
    char           |     1628                           1628     5.1s
    intrinsics     |      301                            301     7.1s
    ambiguous      |      107                    2       109    20.0s
    strings/util   |     1147                           1147    24.7s
    staged         |       64                             64     5.6s
    strings/basic  |    87674                          87674    27.8s
    iobuffer       |      209                            209     8.3s
    tuple          |      625                            625    12.3s
    atomics        |     3444                           3444    42.7s
    hashing        |    12519                          12519    34.8s
    dict           |   144420                         144420    46.4s
    simdloop       |      240                            240     4.9s
    reduce         |     8580     2                     8582    40.3s
    intfuncs       |   227842                         227842    16.9s
    vecelement     |      678                            678    18.1s
    copy           |      533                            533     4.7s
    subtype        |   337674                   19    337693  1m30.1s
    offsetarray    |      487                    3       490  1m22.8s
    core           |      643            1       1       645  1m49.2s
    fastmath       |      946                            946    15.9s
    rational       |    98639                    1     98640    47.9s
    functional     |       98                             98    12.5s
    path           |     1051                   12      1063     2.4s
    numbers        |  1578756                    2   1578758  1m59.5s
    ordering       |       37                             37     5.2s
    parse          |    16098                          16098     6.8s
    operators      |    13040                          13040    19.3s
    gmp            |     2357                           2357    10.6s
    reducedim      |      865                            865  1m43.1s
    backtrace      |       34     4              1        39     5.9s
    exceptions     |       70                             70     5.3s
    file           |        5            1                 6     3.1s
    spawn          |      231     1              4       236    37.6s
    version        |     2452                           2452     6.5s
    namedtuple     |      215                            215     6.2s
    math           |   148979                         148979  2m02.5s
    ccall          |     5352                           5352  1m42.4s
    arrayops       |     2031                    2      2033  3m22.9s
    floatapprox    |       49                             49     3.6s
    mpfr           |     1135                    1      1136    35.0s
    regex          |      130                            130     3.9s
    abstractarray  |    56052                24795     80847  3m17.7s
    reflection     |      415                            415     8.7s
    sysinfo        |        4                              4     0.5s
    env            |       94                             94     1.4s
    float16        |   762093                         762093    11.4s
    rounding       |   112720                         112720     9.2s
    complex        |     8432                    5      8437    27.5s
    mod2pi         |       80                             80     1.0s
    euler          |       12                             12     2.1s
    client         |        5                              5     3.3s
    combinatorics  |      170                            170    28.0s
    errorshow      |      235     3                      238    12.9s
    goto           |       19                             19     4.7s
    llvmcall       |       19                             19     1.6s
    llvmcall2      |        7                              7     0.2s
    ryu            |    31215                          31215     3.4s
    strings/types  |  2302691                        2302691  4m49.0s
    some           |       72                             72     1.8s
    meta           |       69                             69     4.3s
    stacktraces    |       44     4                       48     7.4s
    docs           |      238                            238     9.1s
    sets           |     3594                    1      3595    47.8s
    binaryplatforms |      341                            341    14.0s
    show           |   128879                    8    128887  1m05.7s
    enums          |       99                             99     7.6s
    atexit         |       40                             40    11.9s
    interpreter    |        3                              3     3.1s
    subarray       |   318316                         318316  5m33.0s
    bitset         |      195                            195     5.1s
    ranges         | 12110588               327682  12438270  1m30.5s
    sorting        |    16096                   10     16106  3m26.1s
    iterators      |    10164                          10164  3m49.8s
    int            |   524698                         524698    18.0s
    osutils        |       57                             57     0.8s
    error          |       31                             31     2.4s
    read           |     3870                           3870  2m54.2s
    checked        |     1239                           1239    15.9s
    iostream       |       50                             50     2.4s
    specificity    |      175                            175     0.9s
    secretbuffer   |       27                             27     1.2s
    corelogging    |      231                            231     6.4s
    boundscheck    |                                    None    16.6s
    cartesian      |      343                    3       346    14.9s
    broadcast      |      511                            511  2m27.2s
    smallarrayshrink |       36                             36     0.9s
    filesystem     |        4                              4     0.4s
    syntax         |     1532     1              1      1534    15.6s
    opaque_closure |       35     2      5       1        43     5.2s
    channels       |      258                            258    24.8s
    reinterpretarray |      232                            232    24.0s
    asyncmap       |      304                            304    18.1s
    missing        |      565                    1       566    26.6s
    bitarray       |   914074                         914074  5m06.6s
    download       |                                    None    23.8s
    loading        |   165080     1                   165081  5m14.1s
    misc           |  1282201                        1282201  2m45.1s
    floatfuncs     |      232                            232  2m19.6s
    cmdlineargs    |      255                    3       258  3m09.3s
    precompile     |      123                            123    28.8s
    threads        |       10                    3        13  1m49.5s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0xfc193388bb44e9859f7c2bb8c9e84a30.
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
