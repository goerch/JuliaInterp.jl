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
  Overall          | 21459547    46     38  352561  21812192  8m48.2s
    unicode/utf8   |       19                             19     5.1s
    strings/search |      876                            876    10.0s
    strings/io     |    12764                          12764    10.1s
    strings/types  |  2302691                        2302691    10.2s
    triplequote    |       29                             29     0.2s
    worlds         |       87     1                       88    11.9s
    char           |     1628                           1628     3.0s
    strings/util   |     1147                           1147    14.1s
    keywordargs    |      151                            151    15.5s
    intrinsics     |      301                            301     6.8s
    ambiguous      |      107                    2       109    18.4s
    iobuffer       |      209                            209     3.7s
    strings/basic  |    87674                          87674    19.7s
    core           |      562     2      1       1       566    22.8s
    staged         |       64                             64     6.3s
    tuple          |      625                            625    14.8s
    atomics        |     3444                           3444    35.0s
    simdloop       |      240                            240     5.7s
    hashing        |    12519                          12519    33.3s
    reduce         |     8582                           8582    47.9s
    intfuncs       |   227958                         227958    35.7s
    vecelement     |      678                            678    35.0s
    copy           |      533                            533     5.7s
    subtype        |   337674                   19    337693  1m19.1s
    offsetarray    |      477    10              3       490  1m11.4s
    fastmath       |      946                            946    14.7s
    rational       |    98639                    1     98640    52.4s
    functional     |       98                             98    13.3s
    ordering       |       37                             37     4.7s
    path           |     1051                   12      1063     2.4s
    parse          |    16098                          16098     7.9s
    operators      |    13040                          13040    22.6s
    reducedim      |      865                            865  1m39.9s
    gmp            |     2357                           2357    10.1s
    ccall          |     1806            1              1807    57.0s
    spawn          |      231     1              4       236    35.9s
    numbers        |  1578757     1              2   1578760  2m50.2s
    backtrace      |       38                    1        39     9.9s
    dict           |   144420                         144420  2m47.4s
    file           |        5            1                 6     3.2s
    exceptions     |       65     4      1                70     8.3s
    version        |     2452                           2452     6.8s
    math           |   148979                         148979  2m01.8s
    namedtuple     |      215                            215    11.6s
    floatapprox    |       49                             49     5.1s
    complex        |     8432                    5      8437    14.2s
    mpfr           |     1135                    1      1136    22.4s
    arrayops       |     2031                    2      2033  3m13.6s
    regex          |      130                            130     4.5s
    sysinfo        |        4                              4     0.4s
    env            |       94                             94     1.5s
    reflection     |      415            1               416    14.1s
    combinatorics  |      170                            170    16.0s
    mod2pi         |       80                             80     1.1s
    euler          |       12                             12     2.4s
    rounding       |   112720                         112720    14.3s
    client         |        2     3                        5     5.1s
    abstractarray  |    55657                24795     80452  3m27.0s
    errorshow      |      223     8      1               232    33.6s
    goto           |       19                             19     5.5s
    llvmcall2      |        7                              7     1.0s
    sets           |     3594                    1      3595    48.6s
    ryu            |    31215                          31215     9.0s
    some           |       72                             72     2.0s
    meta           |       69                             69     3.8s
    stacktraces    |       47     1                       48     5.6s
    docs           |      238                            238     9.4s
    iterators      |    10164                          10164  3m43.0s
    float16        |   762093                         762093  1m51.0s
    atexit         |       40                             40    12.1s
    enums          |       99                             99     5.0s
    binaryplatforms |      341                            341    21.3s
    sorting        |    16096                   10     16106  3m27.9s
    interpreter    |        3                              3     2.5s
    checked        |     1239                           1239     3.8s
    subarray       |   318316                         318316  5m36.6s
    bitset         |      195                            195     5.2s
    error          |       31                             31     3.1s
    floatfuncs     |      215                            215    13.1s
    read           |     3870                           3870  2m47.6s
    osutils        |       57                             57     0.3s
    iostream       |       50                             50     2.7s
    secretbuffer   |       27                             27     2.1s
    broadcast      |      509     2                      511  2m37.5s
    boundscheck    |                                    None    17.0s
    specificity    |      175                            175     1.3s
    cartesian      |      343                    3       346    17.3s
    show           |   128879                    8    128887  2m18.5s
    syntax         |     1515     4     14       1      1534    18.5s
    corelogging    |      231                            231    18.4s
    smallarrayshrink |       36                             36     0.4s
    reinterpretarray |      232                            232    26.4s
    opaque_closure |       32     3      6       1        42     3.0s
    filesystem     |        4                              4     0.3s
    asyncmap       |      304                            304    18.3s
    missing        |      564     1              1       566    39.5s
    download       |                                    None    23.8s
    int            |   524698                         524698  1m18.9s
    channels       |      258                            258  1m14.9s
    loading        |   155214     3     11            155228  5m32.6s
    misc           |  1279391            1           1279392  2m18.7s
    bitarray       |   915838                         915838  6m21.6s
    ranges         | 12110547     2         327682  12438231  3m55.0s
    cmdlineargs    |      255                    3       258  3m22.0s
    precompile     |      123                            123    28.5s
    threads        |       10                    3        13  1m34.7s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0x6bc3ab17d739df47587b5d0a485a9c47.
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
