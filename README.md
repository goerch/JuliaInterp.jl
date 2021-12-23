# JuliaInterp.jl

AST/IR interpretation of Julia test suite to improve  https://github.com/JuliaDebug/JuliaInterpreter.jl/issues/13. 
The interpreter processes IR thunks until reaching a time budget per call site or `Core` and `Base` methods. 
It switches to calling compiled methods then.

## Installation

Clone the repository from GitHub.

## Running

Change directory to the root folder of the project,
start Julia (using -t n for the desired number of threads)
and execute

```
use Pkg
Pkg.activate(".")
include("test/runtests.jl")
```

## Results

Julia 1.8.0-DEV on Windows with a time budget of 1000 ns per call site:

```
Test Summary:      |     Pass  Fail  Error  Broken     Total      Time
  Overall          | 21444212    54     43  352561  21796870  10m47.7s
    unicode/utf8   |       19                             19      5.7s
    strings/io     |    12764                          12764     10.8s
    strings/search |      876                            876     11.4s
    keywordargs    |      149     2                      151     15.2s
    char           |     1628                           1628      4.3s
    triplequote    |       29                             29      0.2s
    strings/util   |     1147                           1147     16.6s
    worlds         |       81     2      1                84     16.7s
    ambiguous      |      107                    2       109     19.5s
    intrinsics     |      301                            301      7.2s
    iobuffer       |      209                            209      3.5s
    strings/basic  |    87674                          87674     27.0s
    core           |      561     3      1       1       566     27.2s
    staged         |       64                             64     13.1s
    atomics        |     3444                           3444     40.6s
    tuple          |      625                            625     22.8s
    hashing        |    12519                          12519     35.9s
    simdloop       |      240                            240      5.7s
    vecelement     |      678                            678     20.1s
    reduce         |     8580     2                     8582     50.7s
    subtype        |   337673     1             19    337693   1m18.1s
    intfuncs       |   227952                         227952     40.0s
    offsetarray    |      477    10              3       490   1m19.5s
    copy           |      533                            533     13.3s
    fastmath       |      946                            946     15.3s
    rational       |    98639                    1     98640     52.1s
    functional     |       97            1                98     20.4s
    reducedim      |      865                            865   1m43.9s
    ordering       |       37                             37      5.0s
    operators      |    13040                          13040     14.7s
    path           |     1051                   12      1063      9.9s
    parse          |    16098                          16098      6.6s
    gmp            |     2357                           2357      7.9s
    dict           |   144420                         144420   2m54.0s
    ccall          |     1805            2              1807   1m02.1s
    arrayops       |     2031                    2      2033   3m19.4s
    spawn          |      231     1              4       236     37.1s
    exceptions     |       65     4      1                70      2.0s
    backtrace      |       26     4      8       1        39     14.0s
    math           |   148979                         148979   2m09.2s
    file           |        5            1                 6      2.2s
    strings/types  |  2302691                        2302691   3m57.9s
    version        |     2452                           2452      1.9s
    abstractarray  |    55483                24795     80278   3m23.4s
    namedtuple     |      215                            215      6.1s
    floatapprox    |       49                             49     10.5s
    regex          |      130                            130      6.3s
    complex        |     8432                    5      8437     20.0s
    numbers        |  1578757     1              2   1578760   4m20.3s
    mpfr           |     1135                    1      1136     26.3s
    sysinfo        |        4                              4      0.5s
    env            |       94                             94      1.1s
    reflection     |      203            1               204     17.7s
    combinatorics  |      170                            170     15.8s
    rounding       |   112720                         112720     14.9s
    euler          |       12                             12      2.5s
    mod2pi         |       80                             80      7.0s
    client         |        2     3                        5      5.5s
    errorshow      |      143     2      1               146     14.6s
    goto           |       19                             19      5.9s
    llvmcall2      |        7                              7      1.0s
    ryu            |    31215                          31215      8.8s
    some           |       72                             72      2.2s
    meta           |       69                             69      4.0s
    stacktraces    |       41     4      3                48      6.3s
    subarray       |   318316                         318316   5m44.9s
    sets           |     3594                    1      3595     49.5s
    iterators      |    10164                          10164   3m49.1s
    docs           |      238                            238     10.3s
    binaryplatforms |      341                            341     14.4s
    enums          |       99                             99      7.3s
    atexit         |       40                             40     12.1s
    interpreter    |        3                              3      2.3s
    sorting        |    16096                   10     16106   3m27.4s
    checked        |     1239                           1239      4.1s
    bitset         |      195                            195      4.4s
    float16        |   762093                         762093   1m52.9s
    error          |       31                             31      2.8s
    floatfuncs     |      215                            215     12.6s
    osutils        |       57                             57      0.2s
    boundscheck    |                                    None     16.3s
    iostream       |       50                             50      2.8s
    cartesian      |      343                    3       346     17.1s
    secretbuffer   |       27                             27      3.0s
    specificity    |      175                            175      2.6s
    show           |   128879                    8    128887   2m03.4s
    broadcast      |      509     2                      511   2m52.9s
    corelogging    |      231                            231     11.5s
    syntax         |     1525     4      4       1      1534     20.8s
    reinterpretarray |      232                            232     24.9s
    smallarrayshrink |       36                             36      6.3s
    read           |     3870                           3870   3m16.5s
    filesystem     |        4                              4      0.8s
    opaque_closure |       31     3      7       1        42      8.2s
    asyncmap       |      304                            304     18.8s
    missing        |      564     1              1       566     30.2s
    int            |   524698                         524698   1m27.2s
    download       |                                    None     23.8s
    channels       |      258                            258   1m28.4s
    bitarray       |   913778                         913778   6m25.6s
    loading        |   142416     3     11            142430   5m28.8s
    misc           |  1279391            1           1279392   2m42.2s
    cmdlineargs    |      255                    3       258   3m33.2s
    ranges         | 12110565     2         327682  12438249   6m11.6s
    precompile     |      123                            123     29.4s
    threads        |       10                    3        13   1m41.3s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0x774518d51c2f3fba123d1e374940a5a3.
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
