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

with a time budget of 10 ns per call site:

```
Test Summary:      |     Pass  Fail  Error  Broken     Total      Time
  Overall          | 21342083    43     45  352545  21694716  13m21.8s
    unicode/utf8   |       19                             19      9.1s
    ambiguous      |      107                    2       109     28.8s
    worlds         |       83            1                84     29.0s
    strings/search |      876                            876     30.3s
    keywordargs    |      150     1                      151     30.8s
    char           |     1628                           1628     10.6s
    strings/io     |    12764                          12764     43.6s
    strings/util   |     1147                           1147     49.9s
    intrinsics     |      301                            301      9.1s
    triplequote    |       29                             29     12.4s
    core           |      563     1      1       1       566     52.4s
    staged         |       64                             64      8.0s
    atomics        |     3444                           3444     58.2s
    strings/basic  |    87674                          87674   1m07.2s
    tuple          |      625                            625     38.2s
    hashing        |    12519                          12519   1m10.2s
    subtype        |   337673     1             19    337693   1m46.0s
    simdloop       |      240                            240     20.0s
    reduce         |     8580     2                     8582   1m28.6s
    intfuncs       |   227930                         227930     52.3s
    vecelement     |      678                            678     23.7s
    copy           |      533                            533     25.8s
    fastmath       |      945     1                      946     26.9s
    offsetarray    |      477    10              3       490   2m54.8s
    reducedim      |      865                            865   2m56.6s
    rational       |    98639                    1     98640   1m40.4s
    ordering       |       37                             37     10.7s
    functional     |       98                             98     47.1s
    operators      |    13040                          13040     35.9s
    path           |     1051                   12      1063     17.9s
    numbers        |  1578755     1              2   1578758   4m36.7s
    dict           |   144420                         144420   4m02.5s
    parse          |    16098                          16098     20.2s
    strings/types  |  2302691                        2302691   4m54.4s
    backtrace      |                     1                 1     11.9s
    spawn          |                     1                 1     19.2s
    gmp            |     2357                           2357     29.9s
    exceptions     |       69     1                       70      1.7s
    file           |        5            1                 6     13.9s
    ccall          |     1796            7              1803   1m12.2s
    version        |     2452                           2452     14.1s
    math           |   148979                         148979   3m09.1s
    namedtuple     |      215                            215     29.3s
    floatapprox    |       49                             49     10.2s
    mpfr           |     1135                    1      1136     47.1s
    reflection     |      203            1               204     21.3s
    regex          |      130                            130     10.9s
    complex        |     8432                    5      8437     59.6s
    abstractarray  |    55276                24795     80071   5m47.9s
    sysinfo        |        4                              4     12.2s
    combinatorics  |      170                            170     23.1s
    env            |       94                             94     19.1s
    subarray       |   318316                         318316   7m14.3s
    mod2pi         |       80                             80      3.1s
    arrayops       |     2031                    2      2033   6m27.4s
    euler          |       12                             12      6.1s
    client         |        2     3                        5      5.9s
    rounding       |   112720                         112720     32.2s
    goto           |       19                             19      0.5s
    llvmcall2      |        7                              7      0.8s
    ryu            |    31215                          31215     14.2s
    errorshow      |      143     2      1               146     32.7s
    show           |                     1                 1     41.7s
    some           |       72                             72     10.0s
    stacktraces    |        5            1                 6      6.3s
    meta           |       69                             69     27.3s
    sorting        |    16096                   10     16106   3m50.2s
    docs           |      238                            238     45.2s
    atexit         |       40                             40     15.4s
    binaryplatforms |      341                            341     31.4s
    float16        |   762093                         762093   2m17.5s
    enums          |       99                             99     12.3s
    read           |     3870                           3870   3m46.4s
    checked        |     1239                           1239     13.1s
    bitset         |      195                            195     13.3s
    interpreter    |                     1                 1     23.7s
    iterators      |    10164                          10164   5m34.6s
    sets           |     3594                    1      3595   1m57.0s
    error          |       31                             31      4.7s
    osutils        |       57                             57      0.6s
    boundscheck    |                                    None     19.5s
    floatfuncs     |      215                            215     28.5s
    iostream       |       50                             50     14.3s
    specificity    |      175                            175      2.4s
    secretbuffer   |       27                             27      5.5s
    corelogging    |      231                            231     27.0s
    cartesian      |      343                    3       346     49.5s
    asyncmap       |      304                            304     22.8s
    smallarrayshrink |       36                             36      0.2s
    syntax         |     1519     6      8       1      1534     51.7s
    opaque_closure |       31     4      7       1        43      5.6s
    broadcast      |      509     2                      511   5m04.8s
    filesystem     |        4                              4      6.3s
    int            |   524698                         524698   1m60.0s
    reinterpretarray |      232                            232   1m14.8s
    missing        |      564     1              1       566     51.8s
    bitarray       |   914898                         914898   8m48.1s
    channels       |      256     2                      258   1m46.9s
    download       |                                    None     24.5s
    loading        |   168984     3     11            168998   7m15.1s
    misc           |  1279391            1           1279392   3m47.6s
    ranges         | 12110626     2         327682  12438310   5m18.4s
    cmdlineargs    |                     1                 1   4m18.5s
    precompile     |      123                            123     31.0s
    threads        |       10                    3        13   1m45.8s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0x3a5aeb10eb1f0ec61fbe2dd49a6864e.
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
