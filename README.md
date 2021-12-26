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
  Overall          | 21334526    53     55  352548  21687182  12m23.2s
    unicode/utf8   |       19                             19      7.2s
    core           |      160     1      4               165     20.9s
    strings/io     |    12764                          12764     25.4s
    worlds         |       81     2      1                84     31.1s
    strings/search |      876                            876     31.9s
    keywordargs    |      149     2                      151     33.8s
    triplequote    |       29                             29      2.3s
    ambiguous      |      107                    2       109     37.1s
    intrinsics     |      301                            301     11.2s
    strings/util   |     1147                           1147     47.5s
    atomics        |     3444                           3444     52.0s
    char           |     1628                           1628     22.2s
    staged         |       64                             64     11.8s
    strings/basic  |    87674                          87674   1m01.9s
    tuple          |      624            1               625     43.7s
    hashing        |    12518     1                    12519   1m26.9s
    subtype        |   337672     1      1      19    337693   1m44.8s
    reduce         |     8580     2                     8582   1m37.1s
    simdloop       |      240                            240     22.4s
    vecelement     |      678                            678     28.1s
    intfuncs       |   228000                         228000   1m06.3s
    copy           |      533                            533     20.7s
    reducedim      |      865                            865   2m27.2s
    fastmath       |      946                            946     21.7s
    offsetarray    |      477    10              3       490   2m55.0s
    functional     |       98                             98     19.2s
    rational       |    98639                    1     98640   1m17.8s
    ordering       |       37                             37     15.0s
    operators      |    13040                          13040     22.8s
    path           |     1051                   12      1063     21.3s
    dict           |   144420                         144420   3m40.3s
    parse          |    16098                          16098     11.0s
    gmp            |     2357                           2357     21.1s
    strings/types  |  2302691                        2302691   4m42.6s
    backtrace      |       26     4      8       1        39     15.6s
    ccall          |     1805     1      1              1807   1m04.8s
    spawn          |                     1                 1     32.6s
    exceptions     |       69     1                       70     13.0s
    file           |        5            1                 6     14.5s
    math           |   148979                         148979   2m50.6s
    version        |     2452                           2452     11.9s
    namedtuple     |      215                            215     12.4s
    numbers        |  1578755     1              2   1578758   5m47.1s
    abstractarray  |    55241                24795     80036   4m58.1s
    floatapprox    |       49                             49     22.0s
    subarray       |   318316                         318316   6m26.5s
    complex        |     8432                    5      8437     34.1s
    reflection     |      202            2               204     29.5s
    arrayops       |     2031                    2      2033   5m50.2s
    sysinfo        |        4                              4      0.8s
    env            |       94                             94      1.9s
    mpfr           |     1135                    1      1136   1m01.9s
    combinatorics  |      170                            170     17.9s
    regex          |      130                            130     25.0s
    mod2pi         |       80                             80      6.3s
    client         |        2     3                        5      7.6s
    rounding       |   112720                         112720     46.4s
    euler          |       12                             12     40.5s
    goto           |       19                             19      0.3s
    llvmcall2      |        7                              7      0.5s
    show           |                     1                 1     41.4s
    ryu            |    31215                          31215     14.8s
    sorting        |    16096                   10     16106   3m32.6s
    errorshow      |      143     2      1               146     46.8s
    some           |       72                             72     16.4s
    stacktraces    |       38     6      4                48     10.3s
    meta           |                     1                 1     23.9s
    iterators      |    10164                          10164   4m43.8s
    docs           |      237            1               238     29.4s
    enums          |       99                             99     13.9s
    float16        |   762093                         762093   2m03.4s
    interpreter    |        3                              3      8.2s
    binaryplatforms |      341                            341     35.9s
    atexit         |                     1                 1     32.0s
    sets           |     3594                    1      3595   1m24.4s
    checked        |     1239                           1239     18.2s
    bitset         |      195                            195     15.8s
    error          |       31                             31      6.4s
    osutils        |       57                             57      0.9s
    floatfuncs     |      215                            215     23.4s
    read           |     3870                           3870   3m50.1s
    boundscheck    |                                    None     22.0s
    iostream       |       50                             50      4.3s
    secretbuffer   |       27                             27      6.9s
    specificity    |      175                            175      7.1s
    cartesian      |      343                    3       346     37.8s
    corelogging    |      231                            231     33.9s
    syntax         |     1521     4      8       1      1534     45.8s
    int            |   524698                         524698   1m43.0s
    smallarrayshrink |       36                             36      0.1s
    reinterpretarray |      232                            232     58.9s
    opaque_closure |       33     4      5       1        43      4.9s
    asyncmap       |      304                            304     22.8s
    filesystem     |        4                              4      4.7s
    broadcast      |      509     2                      511   4m42.3s
    missing        |      564     1              1       566     55.4s
    channels       |                     1                 1   1m36.4s
    download       |                                    None     24.2s
    bitarray       |   915122                         915122   8m19.5s
    loading        |   161598     3     11            161612   6m42.3s
    misc           |  1279391            1           1279392   3m23.6s
    ranges         | 12110641     2         327682  12438325   5m22.5s
    cmdlineargs    |      255                    3       258   3m53.4s
    precompile     |      123                            123     27.6s
    threads        |       10                    3        13   1m36.9s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0x3c7a00807bfa89feaec4fdb21e5b1e28.
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
