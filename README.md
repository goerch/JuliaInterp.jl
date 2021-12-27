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
  Overall          | 21464975    20      8  352561  21817564  8m24.7s
    unicode/utf8   |       19                             19     3.2s
    keywordargs    |      151                            151     7.2s
    worlds         |       87     1                       88    10.4s
    strings/io     |    12764                          12764    10.5s
    strings/search |      876                            876    10.7s
    triplequote    |       29                             29     0.3s
    char           |     1628                           1628     4.5s
    ambiguous      |      107                    2       109    17.3s
    intrinsics     |      301                            301     6.7s
    iobuffer       |      209                            209     3.3s
    strings/util   |     1147                           1147    23.2s
    strings/basic  |    87674                          87674    25.6s
    staged         |       64                             64    11.7s
    tuple          |      625                            625    13.2s
    atomics        |     3444                           3444    41.7s
    hashing        |    12519                          12519    36.4s
    dict           |   144420                         144420    46.1s
    simdloop       |      240                            240     5.6s
    subtype        |   337674                   19    337693    59.9s
    intfuncs       |   227964                         227964    17.2s
    reduce         |     8580     2                     8582    42.0s
    copy           |      533                            533    10.6s
    core           |      642     1      1       1       645  1m35.6s
    offsetarray    |      487                    3       490  1m20.9s
    vecelement     |      678                            678    35.2s
    functional     |       98                             98    12.2s
    fastmath       |      946                            946    15.7s
    rational       |    98639                    1     98640    50.7s
    path           |     1051                   12      1063     2.5s
    ordering       |       37                             37     4.7s
    numbers        |  1578756                    2   1578758  2m00.8s
    operators      |    13040                          13040    13.8s
    parse          |    16098                          16098     8.2s
    gmp            |     2357                           2357    11.8s
    reducedim      |      865                            865  1m45.5s
    backtrace      |       34     4              1        39     4.9s
    exceptions     |       70                             70     5.0s
    file           |        5            1                 6     3.9s
    spawn          |      231     1              4       236    37.0s
    version        |     2452                           2452     6.2s
    namedtuple     |      215                            215     6.6s
    math           |   148979                         148979  2m00.5s
    ccall          |     5351            1              5352  1m32.9s
    arrayops       |     2031                    2      2033  3m24.3s
    floatapprox    |       49                             49     3.5s
    mpfr           |     1135                    1      1136    35.0s
    regex          |      130                            130     3.9s
    abstractarray  |    55528                24795     80323  3m16.9s
    reflection     |      415                            415    11.2s
    sysinfo        |        4                              4     0.3s
    env            |       94                             94     1.4s
    float16        |   762093                         762093    10.3s
    rounding       |   112720                         112720     9.3s
    mod2pi         |       80                             80     1.0s
    complex        |     8432                    5      8437    34.0s
    euler          |       12                             12     2.2s
    client         |        5                              5     3.2s
    strings/types  |  2302691                        2302691  4m19.6s
    combinatorics  |      170                            170    28.1s
    goto           |       19                             19     1.4s
    llvmcall2      |        7                              7     0.3s
    ryu            |    31215                          31215     3.5s
    errorshow      |      236     2                      238    12.7s
    some           |       72                             72     1.9s
    meta           |       69                             69     3.8s
    stacktraces    |       46     2                       48     6.8s
    docs           |      238                            238    15.0s
    binaryplatforms |      341                            341    10.6s
    sets           |     3594                    1      3595    47.0s
    enums          |       99                             99     6.8s
    atexit         |       40                             40    16.0s
    show           |   128879                    8    128887  1m11.0s
    interpreter    |        3                              3     2.4s
    subarray       |   318316                         318316  5m34.0s
    iterators      |    10164                          10164  3m53.0s
    ranges         | 12110616               327682  12438298  1m30.7s
    sorting        |    16096                   10     16106  3m27.0s
    int            |   524698                         524698    17.7s
    bitset         |      195                            195     5.3s
    error          |       31                             31     2.4s
    osutils        |       57                             57     0.8s
    iostream       |       50                             50     2.5s
    secretbuffer   |       27                             27     1.6s
    checked        |     1239                           1239    16.5s
    specificity    |      175                            175     1.5s
    floatfuncs     |      215                            215    13.8s
    read           |     3870                           3870  3m00.8s
    cartesian      |      343                    3       346    14.6s
    boundscheck    |                                    None    16.6s
    smallarrayshrink |       36                             36     0.9s
    corelogging    |      231                            231     7.5s
    filesystem     |        4                              4     0.3s
    opaque_closure |       37     2      3       1        43     5.2s
    broadcast      |      511                            511  2m29.5s
    syntax         |     1529     4              1      1534    17.1s
    channels       |      258                            258    26.9s
    reinterpretarray |      232                            232    23.2s
    asyncmap       |      304                            304    17.0s
    bitarray       |   914954                         914954  5m04.0s
    missing        |      565                    1       566    24.1s
    download       |                                    None    24.0s
    loading        |   155105            2            155107  4m59.3s
    misc           |  1282196     1                  1282197  2m29.8s
    cmdlineargs    |      255                    3       258  3m10.8s
    precompile     |      123                            123    29.6s
    threads        |       10                    3        13  1m36.3s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0xea2a3a89cca523a3d04ea2fcbed372f.
```

One long running test is deactivated.

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
