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
  Overall          | 21475472    56     34  352561  21828123  9m54.5s
    unicode/utf8   |       19                             19     4.7s
    strings/io     |    12764                          12764     9.7s
    strings/search |      876                            876    10.0s
    worlds         |       87     1                       88    11.2s
    keywordargs    |      151                            151    11.6s
    triplequote    |       29                             29     0.3s
    char           |     1628                           1628     3.8s
    strings/util   |     1147                           1147    14.1s
    ambiguous      |      107                    2       109    16.8s
    intrinsics     |      301                            301     6.0s
    iobuffer       |      209                            209     5.5s
    staged         |       64                             64     6.1s
    core           |      562     2      1       1       566    24.6s
    strings/basic  |    87674                          87674    25.7s
    tuple          |      625                            625    13.5s
    atomics        |     3444                           3444    37.8s
    hashing        |    12519                          12519    35.5s
    simdloop       |      240                            240     6.3s
    subtype        |   337673     1             19    337693    58.2s
    reduce         |     8580     2                     8582    42.8s
    vecelement     |      678                            678    18.4s
    intfuncs       |   227862                         227862    41.1s
    copy           |      533                            533     6.5s
    offsetarray    |      477    10              3       490  1m21.7s
    fastmath       |      945     1                      946    15.9s
    functional     |       98                             98    19.8s
    rational       |    98639                    1     98640    54.8s
    ordering       |       37                             37     5.0s
    path           |     1051                   12      1063     2.8s
    reducedim      |      865                            865  1m47.7s
    operators      |    13040                          13040    16.7s
    parse          |    16098                          16098     8.2s
    gmp            |     2357                           2357     9.1s
    dict           |   144420                         144420  3m12.2s
    math           |   148979                         148979  2m10.5s
    backtrace      |       34     4              1        39     6.5s
    arrayops       |     2031                    2      2033  3m22.3s
    exceptions     |       67     3                       70     1.9s
    file           |        5            1                 6     9.1s
    ccall          |     5347            3              5350  1m51.3s
    abstractarray  |    55276                24795     80071  3m31.2s
    version        |     2452                           2452     8.2s
    spawn          |      231     1              4       236    51.0s
    strings/types  |  2302691                        2302691  4m23.9s
    namedtuple     |      215                            215    19.7s
    floatapprox    |       49                             49    10.3s
    mpfr           |     1135                    1      1136    21.9s
    regex          |      130                            130     6.2s
    complex        |     8432                    5      8437    21.2s
    sysinfo        |        4                              4     0.5s
    numbers        |  1578755     1              2   1578758  4m41.3s
    reflection     |      415            1               416    18.2s
    env            |       94                             94     1.5s
    combinatorics  |      170                            170    16.9s
    mod2pi         |       80                             80     1.4s
    euler          |       12                             12     2.7s
    rounding       |   112720                         112720    15.3s
    client         |        2     3                        5     5.3s
    errorshow      |      226     6                      232    17.0s
    goto           |       19                             19     6.4s
    llvmcall2      |        7                              7     1.1s
    subarray       |   318316                         318316  5m42.2s
    ryu            |    31215                          31215     8.5s
    some           |       72                             72     2.1s
    meta           |       69                             69     5.7s
    stacktraces    |       46     2                       48     6.5s
    iterators      |    10164                          10164  3m57.7s
    docs           |      238                            238    11.2s
    sets           |     3594                    1      3595    50.0s
    enums          |       99                             99     7.5s
    sorting        |    16096                   10     16106  3m37.6s
    binaryplatforms |      341                            341    22.3s
    atexit         |       40                             40    20.5s
    interpreter    |        3                              3     3.6s
    checked        |     1239                           1239     4.3s
    bitset         |      195                            195     6.6s
    float16        |   762093                         762093  1m59.6s
    error          |       31                             31     2.9s
    floatfuncs     |      215                            215    14.7s
    osutils        |       57                             57     0.3s
    boundscheck    |                                    None    18.0s
    iostream       |       50                             50     2.8s
    secretbuffer   |       27                             27     1.6s
    cartesian      |      343                    3       346    17.0s
    specificity    |      175                            175     2.7s
    broadcast      |      509     2                      511  2m41.3s
    show           |   128879                    8    128887  2m13.5s
    syntax         |     1518     4     11       1      1534    21.6s
    reinterpretarray |      232                            232    24.9s
    smallarrayshrink |       36                             36     6.5s
    corelogging    |      231                            231    26.4s
    filesystem     |        4                              4     0.5s
    opaque_closure |       29     7      6       1        43     4.7s
    asyncmap       |      304                            304    20.8s
    read           |     3870                           3870  3m47.7s
    missing        |      564     1              1       566    33.7s
    int            |   524698                         524698  1m43.0s
    download       |                                    None    24.4s
    bitarray       |   913126                         913126  6m52.2s
    channels       |      258                            258  1m41.5s
    loading        |   167952     3     11            167966  6m22.6s
    ranges         | 12110581     2         327682  12438265  4m08.6s
    misc           |  1282198                        1282198  3m33.9s
    cmdlineargs    |      255                    3       258  3m41.6s
    precompile     |      123                            123    28.8s
    threads        |       10                    3        13  1m35.2s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0x9412884760f5b00f998318dc722a3bee.
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
