# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. 
The interpreter processes IR thunks until reaching a time budget per call site or `Core` methods. 
It switches to calling compiled methods then.

## Installation

Clone the repository from GitHub.

## Running

Change directory to the test folder of the project and execute

```
julia.exe -t5 runtests.jl --skip llvmcall compiler stdlib
```

## Results

Julia 1.8.0-DEV on Windows 

```
Julia Version 1.8.0-DEV.1176
Commit 00646634c6 (2021-12-24 08:23 UTC)
Platform Info:
  OS: Windows (x86_64-w64-mingw32)
  CPU: Intel(R) Core(TM) i7-10710U CPU @ 1.10GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-12.0.1 (ORCJIT, skylake)
```

with a time budget of 1000 ns per call site:

```
Test Summary:      |     Pass  Fail  Error  Broken     Total      Time
  Overall          | 21454181    43     33  352561  21806818  10m14.8s
    unicode/utf8   |       19                             19      5.2s
    worlds         |       88                             88     11.4s
    keywordargs    |      151                            151     11.6s
    strings/io     |    12764                          12764     12.1s
    triplequote    |       29                             29      0.2s
    strings/search |      876                            876     14.2s
    char           |     1628                           1628      3.9s
    strings/util   |     1147                           1147     17.4s
    ambiguous      |      107                    2       109     19.1s
    intrinsics     |      301                            301      7.6s
    iobuffer       |      209                            209      5.6s
    staged         |       64                             64      6.8s
    core           |      564            1       1       566     28.8s
    atomics        |     3444                           3444     39.7s
    strings/basic  |    87674                          87674     43.6s
    tuple          |      625                            625     23.2s
    subtype        |   337674                   19    337693     44.5s
    hashing        |    12519                          12519     49.7s
    simdloop       |      240                            240     10.4s
    reduce         |     8580     2                     8582     57.3s
    intfuncs       |   227826                         227826     57.0s
    offsetarray    |      477    10              3       490   1m30.7s
    vecelement     |      678                            678     50.7s
    copy           |      533                            533     10.1s
    rational       |    98639                    1     98640   1m02.5s
    fastmath       |      946                            946     17.7s
    functional     |       98                             98     22.0s
    reducedim      |      865                            865   1m48.0s
    ordering       |       37                             37     10.1s
    path           |     1051                   12      1063      4.1s
    operators      |    13040                          13040     18.8s
    parse          |    16098                          16098      9.9s
    gmp            |     2357                           2357     11.0s
    ccall          |     1806            1              1807     55.0s
    dict           |   144420                         144420   3m18.6s
    backtrace      |       26     4      8       1        39     17.2s
    exceptions     |       69     1                       70      8.2s
    arrayops       |     2031                    2      2033   3m44.1s
    file           |        5            1                 6      3.2s
    spawn          |      231     1              4       236     43.6s
    version        |     2452                           2452      7.1s
    numbers        |  1578755     1              2   1578758   4m29.4s
    namedtuple     |      215                            215     14.8s
    mpfr           |     1135                    1      1136     26.4s
    floatapprox    |       49                             49      4.5s
    abstractarray  |    55458                24795     80253   4m15.2s
    strings/types  |  2302691                        2302691   5m02.1s
    math           |   148979                         148979   3m11.1s
    reflection     |      203            1               204     12.8s
    complex        |     8432                    5      8437     31.7s
    sysinfo        |        4                              4      0.5s
    env            |       94                             94      1.5s
    regex          |      130                            130     20.1s
    mod2pi         |       80                             80      2.7s
    euler          |       12                             12      2.6s
    combinatorics  |      170                            170     34.5s
    rounding       |   112720                         112720     26.9s
    client         |        2     3                        5      5.2s
    subarray       |   318316                         318316   5m48.4s
    errorshow      |      143     2      1               146     14.2s
    goto           |       19                             19      5.5s
    llvmcall2      |        7                              7      1.1s
    ryu            |    31215                          31215     13.0s
    some           |       72                             72     10.1s
    meta           |       69                             69      5.4s
    stacktraces    |       41     4      3                48      8.1s
    sorting        |    16096                   10     16106   3m30.9s
    iterators      |    10164                          10164   4m17.2s
    docs           |      238                            238     11.0s
    enums          |       99                             99      7.9s
    binaryplatforms |      341                            341     13.1s
    sets           |     3594                    1      3595     51.8s
    interpreter    |        3                              3      2.7s
    atexit         |       40                             40     19.4s
    checked        |     1239                           1239      8.8s
    bitset         |      195                            195      6.6s
    float16        |   762093                         762093   2m05.1s
    floatfuncs     |      215                            215     19.8s
    error          |       31                             31      4.2s
    osutils        |       57                             57      0.9s
    boundscheck    |                                    None     17.2s
    iostream       |       50                             50      4.0s
    secretbuffer   |       27                             27      1.7s
    specificity    |      175                            175      1.6s
    read           |     3870                           3870   3m08.7s
    cartesian      |      343                    3       346     33.5s
    syntax         |     1528     4      1       1      1534     24.5s
    broadcast      |      509     2                      511   3m12.9s
    reinterpretarray |      232                            232     35.8s
    corelogging    |      231                            231     11.4s
    smallarrayshrink |       36                             36      0.3s
    opaque_closure |       35     3      4       1        43      2.7s
    filesystem     |        4                              4      5.1s
    show           |   128879                    8    128887   2m31.7s
    asyncmap       |      304                            304     19.3s
    download       |                                    None     24.3s
    missing        |      564     1              1       566     41.6s
    loading        |   153948     3     11            153962   6m12.1s
    channels       |      258                            258   1m39.0s
    bitarray       |   912370                         912370   7m15.3s
    int            |   524698                         524698   2m22.5s
    ranges         | 12110537     2         327682  12438221   4m05.5s
    misc           |  1279391            1           1279392   3m24.2s
    cmdlineargs    |      255                    3       258   3m36.4s
    precompile     |      123                            123     28.5s
    threads        |       10                    3        13   1m42.1s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0x1ca7dca5d44b5f7a433d7a7ce287b797.
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
