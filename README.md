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
Test Summary:      |     Pass  Fail  Error  Broken     Total     Time
  Overall          | 21477657    22     15  352561  21830255  8m19.5s
    unicode/utf8   |       19                             19     2.7s
    keywordargs    |      151                            151     6.6s
    worlds         |       87     1                       88     9.5s
    strings/io     |    12764                          12764     9.6s
    strings/search |      876                            876     9.8s
    triplequote    |       29                             29     0.2s
    char           |     1628                           1628     3.7s
    ambiguous      |      107                    2       109    15.6s
    intrinsics     |      301                            301     5.8s
    iobuffer       |      209                            209     3.0s
    strings/util   |     1147                           1147    21.2s
    core           |      642     1      1       1       645    22.5s
    strings/basic  |    87674                          87674    24.1s
    subtype        |   337674                   19    337693    19.5s
    staged         |       64                             64    11.4s
    tuple          |      625                            625    12.2s
    atomics        |     3444                           3444    39.0s
    simdloop       |      240                            240     5.2s
    hashing        |    12519                          12519    34.9s
    intfuncs       |   228028                         228028    16.7s
    dict           |   144420                         144420    45.7s
    copy           |      533                            533     5.5s
    reduce         |     8580     2                     8582    41.4s
    vecelement     |      678                            678    36.1s
    functional     |       98                             98    13.3s
    fastmath       |      946                            946    20.4s
    rational       |    98639                    1     98640    49.7s
    offsetarray    |      487                    3       490  1m21.8s
    path           |     1051                   12      1063     2.2s
    ordering       |       37                             37     4.7s
    operators      |    13040                          13040    15.0s
    parse          |    16098                          16098     7.5s
    numbers        |  1578756                    2   1578758  1m58.8s
    gmp            |     2357                           2357    11.0s
    reducedim      |      865                            865  1m46.1s
    backtrace      |       34     4              1        39     8.7s
    exceptions     |       70                             70     6.1s
    file           |        5            1                 6     4.2s
    spawn          |      231     1              4       236    43.2s
    version        |     2452                           2452     6.9s
    math           |   148979                         148979  2m03.6s
    namedtuple     |      215                            215     6.3s
    ccall          |     5342            6              5348  1m39.7s
    mpfr           |     1135                    1      1136    32.4s
    floatapprox    |       49                             49     2.7s
    arrayops       |     2031                    2      2033  3m28.3s
    regex          |      130                            130     4.0s
    reflection     |      415                            415    11.4s
    abstractarray  |    55213                24795     80008  3m26.5s
    complex        |     8432                    5      8437    34.1s
    float16        |   762093                         762093    10.8s
    env            |       94                             94     1.9s
    sysinfo        |        4                              4    13.2s
    combinatorics  |      170                            170    15.5s
    mod2pi         |       80                             80     1.6s
    euler          |       12                             12     2.5s
    rounding       |   112720                         112720     9.1s
    strings/types  |  2302691                        2302691  4m13.5s
    client         |        5                              5     3.4s
    goto           |       19                             19     0.2s
    llvmcall2      |        7                              7     0.2s
    ryu            |    31215                          31215     3.3s
    some           |       72                             72     1.8s
    meta           |       69                             69     3.1s
    stacktraces    |       45     3                       48     3.0s
    errorshow      |      236     2                      238    17.0s
    docs           |      238                            238    16.1s
    sets           |     3594                    1      3595    47.4s
    binaryplatforms |      341                            341    10.8s
    enums          |       99                             99     6.9s
    atexit         |       40                             40    14.3s
    iterators      |    10164                          10164  3m53.3s
    interpreter    |        3                              3     3.2s
    show           |   128879                    8    128887  1m19.7s
    subarray       |   318316                         318316  5m32.9s
    int            |   524698                         524698    19.2s
    sorting        |    16096                   10     16106  3m34.1s
    bitset         |      195                            195     4.9s
    error          |       31                             31     2.4s
    osutils        |       57                             57     0.2s
    ranges         | 12110618               327682  12438300  1m32.4s
    iostream       |       50                             50     2.7s
    secretbuffer   |       27                             27     1.3s
    specificity    |      175                            175     1.3s
    floatfuncs     |      215                            215    13.6s
    broadcast      |      511                            511  2m38.1s
    checked        |     1239                           1239    18.0s
    cartesian      |      343                    3       346    13.6s
    read           |     3870                           3870  3m02.5s
    boundscheck    |                                    None    17.8s
    smallarrayshrink |       36                             36     1.2s
    filesystem     |        4                              4     0.3s
    corelogging    |      231                            231     8.0s
    opaque_closure |       35     2      5       1        43     5.7s
    asyncmap       |      304                            304    15.1s
    syntax         |     1528     5              1      1534    18.1s
    channels       |      258                            258    26.9s
    reinterpretarray |      232                            232    23.2s
    bitarray       |   914686                         914686  5m14.7s
    missing        |      565                    1       566    26.0s
    download       |                                    None    24.3s
    loading        |   168317            2            168319  5m22.0s
    misc           |  1282196     1                  1282197  2m35.9s
    cmdlineargs    |      255                    3       258  3m10.5s
    precompile     |      123                            123    28.3s
    threads        |       10                    3        13  1m34.7s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0xdeb7fe5cf0103b423f2351738838c229.
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
