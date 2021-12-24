# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. 
The interpreter processes IR thunks until reaching a time budget per call site or `Core` and `Base` methods. 
It switches to calling compiled methods then.

## Installation

Clone the repository from GitHub.

## Running

Change directory to the test folder of the project and execute

```
julia.exe -t5 runtests.jl --skip llvmcall compiler stdlib
```

## Results

Julia 1.8.0-DEV on Windows with a time budget of 1000 ns per call site:

```
Test Summary:      |     Pass  Fail  Error  Broken     Total      Time
  Overall          | 21455904    57     43  352561  21808565  10m46.3s
    unicode/utf8   |       19                             19      4.9s
    strings/io     |    12764                          12764     11.1s
    strings/search |      876                            876     11.4s
    char           |     1628                           1628      3.8s
    triplequote    |       29                             29      0.2s
    keywordargs    |      149     2                      151     15.6s
    strings/util   |     1147                           1147     15.9s
    worlds         |       82     1      1                84     16.9s
    ambiguous      |      107                    2       109     19.7s
    intrinsics     |      301                            301      6.7s
    core           |      560     4      1       1       566     24.3s
    iobuffer       |      209                            209      3.2s
    strings/basic  |    87674                          87674     27.1s
    staged         |       64                             64     12.7s
    atomics        |     3444                           3444     39.2s
    tuple          |      625                            625     21.6s
    hashing        |    12519                          12519     33.7s
    simdloop       |      240                            240      6.5s
    reduce         |     8580     2                     8582     47.9s
    intfuncs       |   227952                         227952     37.4s
    subtype        |   337674                   19    337693   1m17.1s
    vecelement     |      678                            678     34.6s
    offsetarray    |      477    10              3       490   1m14.5s
    copy           |      533                            533     13.3s
    fastmath       |      944     2                      946     17.7s
    functional     |       98                             98     21.0s
    rational       |    98639                    1     98640     49.3s
    reducedim      |      865                            865   1m41.7s
    path           |     1051                   12      1063      3.4s
    ordering       |       37                             37      4.8s
    parse          |    16098                          16098      6.4s
    operators      |    13040                          13040     22.8s
    gmp            |     2357                           2357      9.0s
    numbers        |  1578757     1              2   1578760   2m51.8s
    dict           |   144420                         144420   2m49.9s
    backtrace      |       26     4      8       1        39      6.6s
    ccall          |     1805            2              1807   1m00.4s
    exceptions     |       69     1                       70      9.0s
    file           |        5            1                 6      7.5s
    math           |   148979                         148979   2m02.5s
    version        |     2452                           2452      1.6s
    arrayops       |     2031                    2      2033   3m14.1s
    namedtuple     |      215                            215      5.7s
    spawn          |      231     1              4       236     42.6s
    strings/types  |  2302691                        2302691   3m54.9s
    complex        |     8432                    5      8437     13.9s
    floatapprox    |       49                             49      4.6s
    abstractarray  |    56428                24795     81223   3m20.7s
    mpfr           |     1135                    1      1136     19.2s
    sysinfo        |        4                              4      0.3s
    env            |       95                             95      1.2s
    regex          |      130                            130      4.2s
    reflection     |      203            1               204     17.4s
    rounding       |   112720                         112720     15.4s
    mod2pi         |       80                             80      0.8s
    combinatorics  |      170                            170     29.0s
    client         |        2     3                        5      6.8s
    errorshow      |      143     2      1               146     18.5s
    subarray       |   318316                         318316   5m36.5s
    goto           |       19                             19      0.6s
    llvmcall2      |        7                              7      0.7s
    ryu            |    31215                          31215      7.4s
    some           |       72                             72      1.9s
    float16        |   762093                         762093   1m50.7s
    meta           |       69                             69      3.9s
    iterators      |    10164                          10164   3m46.1s
    sets           |     3594                    1      3595     48.0s
    stacktraces    |       37     8      3                48      8.1s
    docs           |      238                            238      9.0s
    sorting        |    16096                   10     16106   3m27.2s
    atexit         |       40                             40     11.8s
    binaryplatforms |      341                            341     15.5s
    interpreter    |        3                              3      2.7s
    enums          |       99                             99     13.2s
    broadcast      |      509     2                      511   2m36.0s
    checked        |     1239                           1239      4.3s
    bitset         |      195                            195      6.0s
    show           |   128879                    8    128887   2m10.9s
    floatfuncs     |      215                            215     12.4s
    osutils        |       57                             57      0.2s
    error          |       31                             31      8.1s
    iostream       |       50                             50      3.4s
    secretbuffer   |       27                             27      1.9s
    read           |     3870                           3870   3m04.3s
    boundscheck    |                                    None     16.6s
    specificity    |      175                            175      2.4s
    cartesian      |      343                    3       346     18.6s
    corelogging    |      231                            231     11.5s
    syntax         |     1522     5      6       1      1534     22.1s
    reinterpretarray |      232                            232     28.2s
    smallarrayshrink |       36                             36      0.3s
    opaque_closure |       31     3      7       1        42      2.7s
    filesystem     |        4                              4      4.5s
    asyncmap       |      304                            304     21.5s
    missing        |      564     1              1       566     33.0s
    int            |   524698                         524698   1m24.4s
    download       |                                    None     23.7s
    channels       |      258                            258   1m21.1s
    bitarray       |   915526                         915526   6m28.7s
    loading        |   151380     3     11            151394   5m36.3s
    misc           |  1279391            1           1279392   2m47.2s
    euler          |       12                             12   4m46.6s
    cmdlineargs    |      255                    3       258   3m26.8s
    ranges         | 12110602     2         327682  12438286   6m40.3s
    precompile     |      123                            123     27.9s
    threads        |       10                    3        13   1m34.6s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0x8326607d8801ae0c14024ad819f266e7.
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
