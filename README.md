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
Test Summary:      |     Pass  Fail  Error  Broken     Total     Time
  Overall          | 21455674    57     61  352561  21808353  9m32.1s
    triplequote    |       29                             29     6.2s
    strings/io     |    12764                          12764    11.0s
    keywordargs    |      150     1                      151    16.0s
    unicode/utf8   |       19                             19    16.6s
    char           |     1628                           1628    17.6s
    intrinsics     |      301                            301    18.9s
    tuple          |      625                            625    21.4s
    iobuffer       |      209                            209    22.1s
    core           |      560     4      1       1       566    27.8s
    simdloop       |      240                            240    12.5s
    strings/search |      876                            876    35.6s
    staged         |       64                             64    39.1s
    worlds         |       87     1                       88    48.6s
    strings/basic  |    87674                          87674    54.0s
    intfuncs       |   228100                         228100    40.0s
    strings/util   |     1147                           1147  1m00.4s
    atomics        |     3444                           3444  1m07.6s
    copy           |      533                            533    29.8s
    path           |     1051                   12      1063    11.8s
    hashing        |    12519                          12519  1m25.7s
    ordering       |       37                             37    20.1s
    ambiguous      |      107                    2       109  1m34.3s
    vecelement     |      678                            678  1m13.2s
    gmp            |     2357                           2357    11.6s
    subtype        |   337674                   19    337693  1m42.6s
    exceptions     |       69     1                       70     4.9s
    functional     |       97            1                98    54.5s
    reduce         |     8580     2                     8582  1m44.3s
    file           |        5            1                 6     9.7s
    parse          |    16098                          16098    29.1s
    operators      |    13040                          13040    59.8s
    version        |     2452                           2452     6.0s
    fastmath       |      945     1                      946  1m19.9s
    ccall          |     1787           12              1799  1m06.1s
    namedtuple     |      215                            215    19.1s
    rational       |    98639                    1     98640  2m13.3s
    offsetarray    |      477    10              3       490  2m39.8s
    reducedim      |      865                            865  2m35.2s
    floatapprox    |       49                             49    11.5s
    backtrace      |       23     4      9       1        37  1m11.5s
    regex          |      130                            130    13.5s
    mpfr           |     1135                    1      1136    59.6s
    env            |       94                             94     3.3s
    complex        |     8432                    5      8437    54.0s
    sysinfo        |        4                              4    18.6s
    reflection     |      203            1               204    53.7s
    spawn          |      231     1              4       236  2m00.2s
    mod2pi         |       80                             80     8.8s
    arrayops       |     2031                    2      2033  3m46.0s
    combinatorics  |      170                            170    49.1s
    numbers        |  1578757     1              2   1578760  3m55.1s
    rounding       |   112720                         112720    46.8s
    math           |   148979                         148979  3m16.3s
    llvmcall2      |        7                              7     0.5s
    dict           |   144420                         144420  4m02.6s
    goto           |       19                             19     1.8s
    client         |        2     3                        5    19.7s
    some           |       72                             72     5.2s
    strings/types  |  2302691                        2302691  4m08.5s
    errorshow      |      143     2      1               146    20.9s
    meta           |       69                             69    13.5s
    ryu            |    31215                          31215    19.1s
    stacktraces    |       36     8      4                48    20.8s
    docs           |      238                            238    27.2s
    sets           |     3594                    1      3595    56.6s
    binaryplatforms |      341                            341    34.2s
    interpreter    |        3                              3    12.3s
    checked        |     1239                           1239    10.2s
    enums          |       99                             99    36.2s
    atexit         |       40                             40    44.7s
    bitset         |      195                            195     8.9s
    osutils        |       57                             57     0.6s
    error          |       31                             31    10.4s
    abstractarray  |    55548                24795     80343  4m59.0s
    iterators      |    10164                          10164  4m26.1s
    iostream       |       50                             50    12.9s
    floatfuncs     |      215                            215    28.7s
    float16        |   762093                         762093  2m44.4s
    specificity    |      175                            175    12.9s
    secretbuffer   |       27                             27    26.0s
    smallarrayshrink |       36                             36     0.9s
    filesystem     |        4                              4     2.0s
    cartesian      |      343                    3       346    54.3s
    missing        |      564     1              1       566    36.0s
    corelogging    |      231                            231    43.7s
    boundscheck    |                                    None  1m11.9s
    opaque_closure |       25     5     11       1        42    29.1s
    asyncmap       |      304                            304    43.6s
    download       |                                    None    30.4s
    reinterpretarray |      232                            232    57.4s
    broadcast      |      509     2                      511  4m02.9s
    syntax         |     1520     5      8       1      1534    58.0s
    int            |   524698                         524698  2m02.8s
    sorting        |    16096                   10     16106  5m26.3s
    show           |   128879                    8    128887  3m22.7s
    channels       |      258                            258  2m34.0s
    read           |     3870                           3870  5m47.7s
    bitarray       |   914122                         914122  7m17.3s
    ranges         | 12110601     2         327682  12438285  4m48.6s
    subarray       |   318316                         318316  8m19.1s
    misc           |  1279391            1           1279392  4m21.7s
    euler          |       12                             12  5m30.7s
    loading        |   153312     3     11            153326  7m49.9s
    cmdlineargs    |      255                    3       258  4m55.4s
    precompile     |      123                            123    27.9s
    threads        |       10                    3        13  1m35.9s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0x20db7f29b2e38b42367e4763fe5d8064.
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
