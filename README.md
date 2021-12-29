# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. 
The interpreter processes IR thunks until reaching a time budget per call site or `Base` or `Core` methods. 
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
  Overall          | 30351186    37     17  352567  30703807
    unicode/utf8   |       19                             19
    keywordargs    |      151                            151
    strings/io     |    12751                          12751
    triplequote    |       29                             29
    strings/search |      692                            692
    worlds         |       83                             83
    intrinsics     |       90                             90
    char           |     1529                           1529
    strings/util   |      461                            461
    iobuffer       |      204                            204
    staged         |       61     3                       64
    ambiguous      |      101                    2       103
    strings/basic  |    87674                          87674
    tuple          |      578                            578
    hashing        |    12356                          12356
    dict           |   144409                         144409
    simdloop       |      249                            249
    intfuncs       |   215864                         215864
    reduce         |     8543     2                     8545
    vecelement     |      678                            678
    copy           |      532                            532
    subtype        |   337653                   16    337669
    offsetarray    |      477                    3       480
    reducedim      |      817                            817
    fastmath       |      934                            934
    rational       |    98622                    1     98623
    functional     |       95                             95
    path           |     1015                   12      1027
    ordering       |       35                             35
    operators      |    12949                          12949
    numbers        |  1578565                    1   1578566
    parse          |    16098                          16098
    gmp            |     2315                           2315
    spawn          |      200                    4       204
    abstractarray  |    54924                24795     79719
    backtrace      |       29     4      2       1        36
    exceptions     |       70                             70
    file           |        5            1                 6
    math           |  1520143                        1520143
    version        |     2452                           2452
    namedtuple     |      194                    1       195
    arrayops       |     1979                    2      1981
    ccall          |     5312           10              5322
    mpfr           |     1135                           1135
    floatapprox    |       49                             49
    complex        |     8429                    5      8434
    regex          |      114                            114
    reflection     |      403                            403
    sysinfo        |        4                              4
    combinatorics  |      170                            170
    env            |       96                             96
    float16        |      235                            235
    mod2pi         |       80                             80
    euler          |       12                             12
    rounding       |   112720                         112720
    client         |        3                              3
    errorshow      |      198    19                      217
    iterators      |    10071                          10071
    goto           |       19                             19
    llvmcall       |       19                             19
    llvmcall2      |        7                              7
    ryu            |    31215                          31215
    some           |       65                             65
    meta           |       64                             64
    stacktraces    |       45     3                       48
    core           |  8445868     4      2       4   8445878
    strings/types  |  2302691                        2302691
    sorting        |    12709                   10     12719
    read           |     3141                           3141
    docs           |      227                            227
    sets           |     3518                    1      3519
    binaryplatforms |      341                            341
    ranges         | 12109732               327693  12437425
    show           |     1520                    8      1528
    interpreter    |        3                              3
    enums          |       99                             99
    atexit         |       40                             40
    bitset         |      195                            195
    error          |       31                             31
    osutils        |       56                             56
    broadcast      |      480                            480
    iostream       |       50                             50
    int            |   524668                         524668
    cartesian      |      234                    3       237
    boundscheck    |                                No tests
    secretbuffer   |       27                             27
    checked        |     1239                           1239
    specificity    |      175                            175
    corelogging    |      231                            231
    subarray       |   318299                         318299
    smallarrayshrink |       36                             36
    filesystem     |        3     1                        4
    syntax         |     1408                    1      1409
    bitarray       |   909062                         909062
    channels       |      237                            237
    asyncmap       |      292                            292
    reinterpretarray |      226                            226
    missing        |      472                    1       473
    download       |                                No tests
    loading        |   144119     1                   144120
    floatfuncs     |      193                            193
    misc           |  1282119            2           1282121
    cmdlineargs    |      238                    3       241
    precompile     |      116                            116
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0xc9b1278af651e1a450fd25c67e411f1a.
```

### Julia 1.7.1 on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total
  Overall          | 29890656    48      8  352559  30243271
    unicode/utf8   |       19                             19
    keywordargs    |      151                            151
    strings/io     |    12764                          12764
    worlds         |       83                             83
    triplequote    |       29                             29
    strings/search |      692                            692
    char           |     1623                           1623
    intrinsics     |      301                            301
    ambiguous      |      106                    2       108
    strings/util   |      619                            619
    iobuffer       |      205                            205
    staged         |       62     2                       64
    strings/basic  |    87674                          87674
    atomics        |     3444                           3444
    tuple          |      606                            606
    hashing        |    12519                          12519
    subtype        |   337674                   19    337693
    dict           |   144420                         144420
    simdloop       |      240                            240
    intfuncs       |   215864                         215864
    vecelement     |      678                            678
    reduce         |     8578     2                     8580
    copy           |      533                            533
    fastmath       |      946                            946
    rational       |    98634                    1     98635
    offsetarray    |      485                    3       488
    numbers        |  1578627                    1   1578628
    functional     |       98                             98
    path           |     1051                   12      1063
    ordering       |       35                             35
    parse          |    16098                          16098
    reducedim      |      865                            865
    operators      |    13039                          13039
    gmp            |     2324                           2324
    math           |   148810                         148810
    backtrace      |       34     4              1        39
    spawn          |      210     1              4       215
    exceptions     |       70                             70
    file           |        5            1                 6
    arrayops       |     2013                    2      2015
    version        |     2452                           2452
    namedtuple     |      214                            214
    ccall          |     5350            1              5351
    abstractarray  |    55512                24795     80307
    mpfr           |     1127                    1      1128
    floatapprox    |       49                             49
    regex          |      130                            130
    complex        |     8432                    5      8437
    reflection     |      411                            411
    sysinfo        |        4                              4
    env            |       96                             96
    float16        |   762091                         762091
    rounding       |   112720                         112720
    core           |  8445875     6      1       3   8445885
    mod2pi         |       80                             80
    euler          |       12                             12
    combinatorics  |      170                            170
    client         |        4                              4
    errorshow      |      197    25                      222
    goto           |       19                             19
    llvmcall       |       19                             19
    llvmcall2      |        7                              7
    ryu            |    31215                          31215
    some           |       71                             71
    sorting        |    12709                   10     12719
    meta           |       69                             69
    sets           |     3529                    1      3530
    stacktraces    |       42     6                       48
    docs           |      236                            236
    subarray       |   318299                         318299
    binaryplatforms |      341                            341
    strings/types  |  2302691                        2302691
    broadcast      |      508                            508
    enums          |       99                             99
    read           |     3725                           3725
    iterators      |    10080                          10080
    interpreter    |        3                              3
    show           |   128869                    8    128877
    atexit         |       40                             40
    bitset         |      195                            195
    error          |       31                             31
    osutils        |       57                             57
    ranges         | 12110540               327682  12438222
    iostream       |       50                             50
    secretbuffer   |       27                             27
    specificity    |      175                            175
    checked        |     1239                           1239
    cartesian      |      238                    3       241
    int            |   524693                         524693
    boundscheck    |                                No tests
    smallarrayshrink |       36                             36
    corelogging    |      231                            231
    filesystem     |        4                              4
    bitarray       |   914982                         914982
    opaque_closure |       37     1      3       1        42
    syntax         |     1509                    1      1510
    channels       |      244                            244
    reinterpretarray |      232                            232
    asyncmap       |      304                            304
    missing        |      565                    1       566
    download       |                                No tests
    loading        |   152793     1                   152794
    floatfuncs     |      221                            221
    misc           |  1282168            2           1282170
    cmdlineargs    |      242                    3       245
    precompile     |      117                            117
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0x842bd3c49edf69f5cf9154aeaa3b8180.
```

### Julia 1.8.0-DEV on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total     Time
  Overall          | 29910990    62     10  352563  30263625  9m39.9s
    unicode/utf8   |       19                             19     3.5s
    keywordargs    |      151                            151     7.8s
    strings/io     |    12764                          12764    11.1s
    worlds         |       87     1                       88    11.5s
    strings/search |      876                            876    13.9s
    triplequote    |       29                             29     0.3s
    char           |     1628                           1628     4.8s
    ambiguous      |      107                    2       109    20.7s
    intrinsics     |      301                            301     6.9s
    iobuffer       |      209                            209     3.7s
    strings/util   |     1147                           1147    25.8s
    strings/basic  |    87674                          87674    33.0s
    staged         |       51    13                       64    12.1s
    tuple          |      625                            625    13.2s
    atomics        |     3444                           3444    47.4s
    dict           |   144420                         144420    50.6s
    hashing        |    12519                          12519    47.8s
    simdloop       |      240                            240     5.6s
    intfuncs       |   227878                         227878    18.0s
    vecelement     |      678                            678    19.7s
    reduce         |     8580     2                     8582    53.0s
    copy           |      533                            533    11.7s
    subtype        |   337674                   19    337693  1m52.3s
    offsetarray    |      487                    3       490  1m47.0s
    numbers        |  1578756                    2   1578758  2m08.5s
    rational       |    98639                    1     98640    50.4s
    fastmath       |      946                            946    17.3s
    ordering       |       37                             37     5.1s
    functional     |       98                             98    12.4s
    path           |     1051                   12      1063     2.6s
    operators      |    13040                          13040    13.9s
    parse          |    16098                          16098     9.4s
    reducedim      |      865                            865  1m50.2s
    gmp            |     2357                           2357    11.8s
    spawn          |      231     1              4       236    44.1s
    backtrace      |       32     4      2       1        39    14.9s
    math           |   148979                         148979  2m10.4s
    arrayops       |     2031                    2      2033  3m40.5s
    exceptions     |       70                             70     6.3s
    file           |        5            1                 6     4.8s
    version        |     2452                           2452     4.0s
    ccall          |     5352                           5352  1m53.9s
    namedtuple     |      215                            215     6.3s
    abstractarray  |    55303                24795     80098  3m32.4s
    floatapprox    |       49                             49    18.5s
    complex        |     8432                    5      8437    31.8s
    core           |  8445915     4      2       3   8445924  4m52.3s
    regex          |      130                            130     4.4s
    reflection     |      415                            415    19.0s
    mpfr           |     1135                    1      1136    43.1s
    sysinfo        |        4                              4     0.6s
    float16        |   762093                         762093    10.9s
    env            |       94                             94     8.6s
    mod2pi         |       80                             80     1.8s
    rounding       |   112720                         112720    10.0s
    euler          |       12                             12     3.3s
    combinatorics  |      170                            170    17.5s
    client         |        5                              5     3.7s
    errorshow      |      211    27                      238    19.2s
    goto           |       19                             19     7.9s
    strings/types  |  2302691                        2302691  5m50.9s
    llvmcall2      |        7                              7     0.8s
    llvmcall       |       19                             19     1.7s
    some           |       72                             72     2.0s
    ryu            |    31215                          31215     4.1s
    meta           |       69                             69     4.9s
    subarray       |   318316                         318316  5m59.6s
    stacktraces    |       41     7                       48     8.3s
    sets           |     3594                    1      3595    50.0s
    docs           |      238                            238    11.9s
    binaryplatforms |      341                            341    11.5s
    iterators      |    10164                          10164  4m07.5s
    atexit         |       40                             40    14.7s
    enums          |       99                             99    14.6s
    sorting        |    16096                   10     16106  3m50.6s
    interpreter    |        3                              3     2.8s
    bitset         |      195                            195     4.5s
    int            |   524698                         524698    13.6s
    show           |   128879                    8    128887  1m24.2s
    error          |       31                             31     2.5s
    osutils        |       57                             57     0.2s
    checked        |     1239                           1239    16.9s
    ranges         | 12110615               327682  12438297  1m38.0s
    secretbuffer   |       27                             27     1.3s
    iostream       |       50                             50     2.9s
    specificity    |      175                            175     2.4s
    boundscheck    |                                    None    16.8s
    cartesian      |      343                    3       346    15.2s
    corelogging    |      231                            231     7.6s
    broadcast      |      511                            511  2m40.5s
    smallarrayshrink |       36                             36     1.1s
    channels       |      258                            258    28.2s
    filesystem     |        4                              4     0.5s
    opaque_closure |       37     2      3       1        43     5.9s
    bitarray       |   916290                         916290  5m33.8s
    syntax         |     1533                    1      1534    19.5s
    read           |     3870                           3870  3m08.7s
    reinterpretarray |      232                            232    28.4s
    asyncmap       |      304                            304    20.2s
    missing        |      565                    1       566    29.5s
    download       |                                    None    24.0s
    loading        |   154826     1                   154827  5m43.2s
    floatfuncs     |      232                            232  2m25.3s
    misc           |  1282197            2           1282199  3m11.4s
    cmdlineargs    |      255                    3       258  3m19.9s
    precompile     |      123                            123    30.7s
    threads        |       10                    3        13  1m42.8s
    stress         |                                    None     0.0s
    FAILURE
    
The global RNG seed was 0xc500e86c46b31d7d2793b43c716e1f9.
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
:interpret_lower = :interpret_lower
codestate.src = CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = 1 + 1
└──      return %1
)
:run_code_state = :run_code_state
codestate.pc = 1
codestate.src.code[codestate.pc] = :(1 + 1)
:interpret_lower = :interpret_lower
expr = :(1 + 1)
:interpret_lower = :interpret_lower
T = :call
args = Any[:+, 1, 1]
:run_code_state = :run_code_state
codestate.pc = 2
codestate.src.code[codestate.pc] = :(return %1)
:interpret_lower = :interpret_lower
returnnode = :(return %1)
:run_code_state = :run_code_state
ans = Some(2)
:eval_lower_ast = :eval_lower_ast
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
:eval_lower_ast = :eval_lower_ast
ans = nothing
:call = :call
args = Any[:(JuliaInterp.interpret_ast), :Main, :(Meta.parse("1 + 1")), false, :(UInt64(1000000))]
:eval_lower_ast = :eval_lower_ast
expr = :(JuliaInterp.interpret_ast(Main, Meta.parse("1 + 1"), false, UInt64(1000000)))
:interpret_lower = :interpret_lower
codestate.src = CodeInfo(
    @ none within `top-level scope`
1 ─ %1 = Base.getproperty(JuliaInterp, :interpret_ast)
│   %2 = Base.getproperty(Meta, :parse)
│   %3 = (%2)("1 + 1")
│   %4 = UInt64(1000000)
│   %5 = (%1)(Main, %3, false, %4)
└──      return %5
)
:run_code_state = :run_code_state
codestate.pc = 1
codestate.src.code[codestate.pc] = :(Base.getproperty(JuliaInterp, :interpret_ast))
:interpret_lower = :interpret_lower
expr = :(Base.getproperty(JuliaInterp, :interpret_ast))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(Base.getproperty), :JuliaInterp, :(:interpret_ast)]
:run_code_state = :run_code_state
codestate.pc = 2
codestate.src.code[codestate.pc] = :(Base.getproperty(Meta, :parse))
:interpret_lower = :interpret_lower
expr = :(Base.getproperty(Meta, :parse))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(Base.getproperty), :Meta, :(:parse)]
:run_code_state = :run_code_state
codestate.pc = 3
codestate.src.code[codestate.pc] = :((%2)("1 + 1"))
:interpret_lower = :interpret_lower
expr = :((%2)("1 + 1"))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(%2), "1 + 1"]
:run_code_state = :run_code_state
codestate.pc = 4
codestate.src.code[codestate.pc] = :(UInt64(1000000))
:interpret_lower = :interpret_lower
expr = :(UInt64(1000000))
:interpret_lower = :interpret_lower
T = :call
args = Any[:UInt64, 1000000]
:run_code_state = :run_code_state
codestate.pc = 5
codestate.src.code[codestate.pc] = :((%1)(Main, %3, false, %4))
:interpret_lower = :interpret_lower
expr = :((%1)(Main, %3, false, %4))
:interpret_lower = :interpret_lower
T = :call
args = Any[:(%1), :Main, :(%3), false, :(%4)]
:run_code_state = :run_code_state
codestate.pc = 6
codestate.src.code[codestate.pc] = :(return %5)
:interpret_lower = :interpret_lower
returnnode = :(return %5)
:run_code_state = :run_code_state
ans = Some(2)
:eval_lower_ast = :eval_lower_ast
ans = 2
2
```
