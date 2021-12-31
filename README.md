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
  Overall          | 29077667    37      2  352567  29430273
    unicode/utf8   |       19                             19
    strings/io     |    12751                          12751
    strings/util   |      461                            461
    keywordargs    |      151                            151
    strings/search |      692                            692
    char           |     1529                           1529
    triplequote    |       29                             29
    intrinsics     |       90                             90
    worlds         |       83                             83
    iobuffer       |      204                            204
    staged         |       55     9                       64
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
    offsetarray    |      477                    3       480
    reducedim      |      817                            817
    subtype        |   337653                   16    337669
    rational       |    98622                    1     98623
    numbers        |  1578565                    1   1578566
    fastmath       |      934                            934
    path           |     1015                   12      1027
    ordering       |       35                             35
    functional     |       95                             95
    operators      |    12949                          12949
    parse          |    16098                          16098
    gmp            |     2315                           2315
    abstractarray  |    54778                24795     79573
    spawn          |      200                    4       204
    exceptions     |       70                             70
    file           |        5            1                 6
    arrayops       |     1979                    2      1981
    backtrace      |       31     4              1        36
    version        |     2452                           2452
    math           |  1520143                        1520143
    namedtuple     |      194                    1       195
    ccall          |     5331            1              5332
    mpfr           |     1135                           1135
    floatapprox    |       49                             49
    core           |  8445869     5              4   8445878
    complex        |     8429                    5      8434
    regex          |      114                            114
    reflection     |      403                            403
    sysinfo        |        4                              4
    float16        |      235                            235
    env            |       96                             96
    mod2pi         |       80                             80
    combinatorics  |      170                            170
    euler          |       12                             12
    client         |        3                              3
    rounding       |   112720                         112720
    iterators      |    10071                          10071
    errorshow      |      213     4                      217
    goto           |       19                             19
    llvmcall       |       19                             19
    llvmcall2      |        7                              7
    ryu            |    31215                          31215
    some           |       65                             65
    meta           |       64                             64
    sorting        |    12709                   10     12719
    sets           |     3518                    1      3519
    stacktraces    |       38    10                       48
    docs           |      227                            227
    binaryplatforms |      341                            341
    enums          |       99                             99
    atexit         |       40                             40
    subarray       |   318299                         318299
    bitset         |      195                            195
    interpreter    |        3                              3
    int            |   524668                         524668
    ranges         | 12109743               327693  12437436
    error          |       31                             31
    checked        |     1239                           1239
    bitarray       |   912794                         912794
    osutils        |       56                             56
    show           |     1520                    8      1528
    iostream       |       50                             50
    secretbuffer   |       27                             27
    boundscheck    |                                No tests
    specificity    |      175                            175
    cartesian      |      234                    3       237
    corelogging    |      231                            231
    smallarrayshrink |       36                             36
    filesystem     |        3     1                        4
    broadcast      |      480                            480
    syntax         |     1407     1              1      1409
    asyncmap       |      292                            292
    channels       |      237                            237
    missing        |      472                    1       473
    read           |     3141                           3141
    reinterpretarray |      226                            226
    strings/types  |  2302691                        2302691
    download       |                                No tests
    loading        |   149099     1                   149100
    floatfuncs     |      193                            193
    cmdlineargs    |      238                    3       241
    precompile     |      116                            116
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0x17d340e118d0ecbfea97a18d00eb340a.
```

### Julia 1.7.1 on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total
  Overall          | 28628918    22      5  352559  28981504
    unicode/utf8   |       19                             19
    strings/io     |    12764                          12764
    keywordargs    |      151                            151
    strings/search |      692                            692
    triplequote    |       29                             29
    char           |     1623                           1623
    worlds         |       83                             83
    strings/util   |      619                            619
    intrinsics     |      301                            301
    iobuffer       |      205                            205
    ambiguous      |      106                    2       108
    strings/basic  |    87674                          87674
    staged         |       60     4                       64
    subtype        |   337674                   19    337693
    tuple          |      606                            606
    atomics        |     3444                           3444
    hashing        |    12519                          12519
    dict           |   144420                         144420
    intfuncs       |   215864                         215864
    simdloop       |      240                            240
    vecelement     |      678                            678
    copy           |      533                            533
    reduce         |     8578     2                     8580
    rational       |    98634                    1     98635
    numbers        |  1578627                    1   1578628
    fastmath       |      946                            946
    functional     |       98                             98
    ordering       |       35                             35
    path           |     1051                   12      1063
    reducedim      |      865                            865
    operators      |    13039                          13039
    parse          |    16098                          16098
    gmp            |     2324                           2324
    math           |   148810                         148810
    offsetarray    |      485                    3       488
    arrayops       |     2013                    2      2015
    exceptions     |       70                             70
    file           |        5            1                 6
    backtrace      |       34     4              1        39
    spawn          |      210     1              4       215
    core           |  8445877     5              3   8445885
    version        |     2452                           2452
    abstractarray  |    55344                24795     80139
    ccall          |     5351                           5351
    namedtuple     |      214                            214
    floatapprox    |       49                             49
    regex          |      130                            130
    float16        |   762091                         762091
    mpfr           |     1127                    1      1128
    sysinfo        |        4                              4
    env            |       96                             96
    reflection     |      411                            411
    rounding       |   112720                         112720
    combinatorics  |      170                            170
    mod2pi         |       80                             80
    complex        |     8432                    5      8437
    euler          |       12                             12
    client         |        4                              4
    errorshow      |      220     2                      222
    subarray       |   318299                         318299
    goto           |       19                             19
    llvmcall       |       19                             19
    ryu            |    31215                          31215
    llvmcall2      |        7                              7
    some           |       71                             71
    meta           |       69                             69
    sets           |     3529                    1      3530
    stacktraces    |       46     2                       48
    sorting        |    12709                   10     12719
    binaryplatforms |      341                            341
    enums          |       99                             99
    docs           |      234            1               235
    atexit         |       40                             40
    iterators      |    10080                          10080
    interpreter    |        3                              3
    int            |   524693                         524693
    bitarray       |   915210                         915210
    error          |       31                             31
    show           |   128869                    8    128877
    osutils        |       57                             57
    bitset         |      195                            195
    ranges         | 12110508               327682  12438190
    iostream       |       50                             50
    secretbuffer   |       27                             27
    checked        |     1239                           1239
    cartesian      |      238                    3       241
    boundscheck    |                                No tests
    specificity    |      175                            175
    corelogging    |      231                            231
    smallarrayshrink |       36                             36
    channels       |      244                            244
    filesystem     |        4                              4
    read           |     3725                           3725
    opaque_closure |       37     1      3       1        42
    syntax         |     1509                    1      1510
    reinterpretarray |      232                            232
    asyncmap       |      304                            304
    missing        |      565                    1       566
    download       |                                No tests
    strings/types  |  2302691                        2302691
    broadcast      |      508                            508
    floatfuncs     |      221                            221
    loading        |   173169     1                   173170
    cmdlineargs    |      242                    3       245
    precompile     |      117                            117
    threads        |        1                              1
    stress         |                                No tests
    FAILURE

The global RNG seed was 0x3996075caecdd049142859d04a21847a.
```

### Julia 1.8.0-DEV on Windows 

```
Test Summary:      |     Pass  Fail  Error  Broken     Total      Time
  Overall          | 28622964    25      9  352563  28975561  11m02.2s
    unicode/utf8   |       19                             19      4.0s
    keywordargs    |      151                            151     13.9s
    strings/io     |    12764                          12764     15.4s
    strings/search |      876                            876     20.1s
    char           |     1628                           1628      6.6s
    triplequote    |       29                             29      2.0s
    worlds         |       87     1                       88     26.0s
    strings/util   |     1147                           1147     28.3s
    ambiguous      |      107                    2       109     30.6s
    intrinsics     |      301                            301     12.7s
    iobuffer       |      209                            209      6.6s
    strings/basic  |    87674                          87674     48.3s
    staged         |       58     6                       64     14.7s
    atomics        |     3444                           3444   1m02.1s
    tuple          |      625                            625     16.6s
    hashing        |    12519                          12519     50.3s
    dict           |   144420                         144420     57.1s
    simdloop       |      240                            240     14.5s
    intfuncs       |   227912                         227912     21.3s
    vecelement     |      678                            678     26.5s
    reduce         |     8580     2                     8582   1m12.9s
    numbers        |  1578756                    2   1578758   2m32.2s
    copy           |      533                            533     15.6s
    rational       |    98639                    1     98640     59.7s
    subtype        |   337674                   19    337693   2m27.7s
    fastmath       |      946                            946     23.1s
    functional     |       98                             98     20.6s
    ordering       |       37                             37      6.5s
    path           |     1051                   12      1063      3.5s
    operators      |    13040                          13040     20.5s
    reducedim      |      865                            865   2m25.9s
    parse          |    16098                          16098     12.2s
    gmp            |     2357                           2357     20.5s
    offsetarray    |      487                    3       490   3m55.9s
    arrayops       |     2031                    2      2033   4m08.1s
    math           |   148979                         148979   2m17.1s
    exceptions     |       70                             70      1.5s
    file           |        5            1                 6      3.0s
    backtrace      |       32     4      2       1        39     12.8s
    abstractarray  |    55468                24795     80263   3m58.2s
    spawn          |      231     1              4       236     44.0s
    version        |     2452                           2452     11.9s
    ccall          |     5352                           5352   2m10.1s
    namedtuple     |      215                            215     22.1s
    floatapprox    |       49                             49      5.0s
    mpfr           |     1135                    1      1136     39.4s
    regex          |      130                            130      4.9s
    complex        |     8432                    5      8437     39.7s
    reflection     |      415                            415     23.9s
    sysinfo        |        4                              4      1.0s
    env            |       94                             94      2.0s
    float16        |   762093                         762093     11.7s
    rounding       |   112720                         112720     11.0s
    mod2pi         |       80                             80      2.0s
    combinatorics  |      170                            170     17.4s
    subarray       |   318316                         318316   6m22.9s
    client         |        5                              5      3.9s
    euler          |       12                             12     10.3s
    errorshow      |      236     2                      238     27.5s
    goto           |       19                             19     12.5s
    llvmcall       |       19                             19      3.9s
    iterators      |    10164                          10164   4m37.7s
    sets           |     3594                    1      3595     50.2s
    llvmcall2      |        7                              7      1.1s
    some           |       72                             72      2.3s
    ryu            |    31215                          31215      4.4s
    meta           |       69                             69      7.0s
    core           |  8445917     4              3   8445924   7m30.8s
    stacktraces    |       46     2                       48     10.7s
    sorting        |    16096                   10     16106   3m42.4s
    binaryplatforms |      341                            341     12.4s
    docs           |      234            1               235     18.1s
    show           |   128879                    8    128887   1m28.3s
    atexit         |       40                             40     14.0s
    interpreter    |        3                              3      3.0s
    ranges         | 12110572               327682  12438254   1m39.3s
    enums          |       99                             99     16.2s
    bitarray       |   912882                         912882   5m55.7s
    bitset         |      195                            195      5.5s
    osutils        |       57                             57      1.0s
    error          |       31                             31      3.0s
    iostream       |       50                             50      3.3s
    secretbuffer   |       27                             27      1.6s
    checked        |     1239                           1239     16.7s
    specificity    |      175                            175      6.7s
    int            |   524698                         524698     25.1s
    boundscheck    |                                    None     20.2s
    cartesian      |      343                    3       346     17.2s
    corelogging    |      231                            231      8.4s
    smallarrayshrink |       36                             36      1.5s
    channels       |      258                            258     28.3s
    filesystem     |        4                              4      0.9s
    read           |     3870                           3870   3m28.2s
    opaque_closure |       35     2      5       1        43     15.0s
    asyncmap       |      304                            304     22.7s
    reinterpretarray |      232                            232     30.9s
    syntax         |     1533                    1      1534     28.4s
    strings/types  |  2302691                        2302691   8m39.3s
    missing        |      565                    1       566     31.6s
    download       |                                    None     25.1s
    broadcast      |      511                            511   3m34.0s
    loading        |   152216     1                   152217   5m55.6s
    floatfuncs     |      232                            232   2m11.6s
    cmdlineargs    |      255                    3       258   3m21.9s
    precompile     |      123                            123     32.0s
    threads        |       10                    3        13   1m42.1s
    stress         |                                    None      0.2s
    FAILURE

The global RNG seed was 0x73e40de6b67072ead8e0b1e5f985d0e2.
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
