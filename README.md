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
  Overall          | 21450712    52     39  352558  21803361  9m23.9s
    unicode/utf8   |       19                             19     4.5s
    strings/search |      876                            876     9.5s
    strings/io     |    12764                          12764     9.7s
    triplequote    |       29                             29     0.2s
    strings/types  |  2302691                        2302691    12.0s
    strings/util   |     1147                           1147    14.0s
    char           |     1628                           1628     4.6s
    keywordargs    |      150     1                      151    14.2s
    worlds         |       82     1      1                84    14.4s
    ambiguous      |      107                    2       109    15.2s
    iobuffer       |      209                            209     3.5s
    intrinsics     |      301                            301     8.0s
    strings/basic  |    87674                          87674    19.6s
    staged         |       64                             64     5.4s
    tuple          |      625                            625    14.6s
    atomics        |     3444                           3444    39.4s
    simdloop       |      240                            240     6.9s
    hashing        |    12519                          12519    39.9s
    vecelement     |      678                            678    20.3s
    reduce         |     8582                           8582    48.7s
    intfuncs       |   227924                         227924    37.5s
    copy           |      533                            533     6.1s
    subtype        |   337673     1             19    337693  1m21.6s
    core           |      561     3      1       1       566  1m29.0s
    offsetarray    |      477    10              3       490  1m12.8s
    fastmath       |      946                            946    16.9s
    functional     |       98                             98    11.4s
    rational       |    98639                    1     98640    55.5s
    ordering       |       37                             37     5.8s
    path           |     1051                   12      1063     3.3s
    parse          |    16098                          16098     7.8s
    operators      |    13040                          13040    22.4s
    gmp            |     2357                           2357     8.5s
    reducedim      |      865                            865  2m05.3s
    backtrace      |       38                    1        39     6.8s
    exceptions     |       65     4      1                70     2.3s
    ccall          |     1805            2              1807    58.2s
    file           |        5            1                 6     8.8s
    spawn          |      231     1              4       236    50.9s
    dict           |   144420                         144420  2m56.5s
    version        |     2452                           2452     7.8s
    namedtuple     |      215                            215     6.9s
    math           |   148979                         148979  2m16.2s
    floatapprox    |       49                             49     3.3s
    reflection     |                     1                 1     4.7s
    complex        |     8432                    5      8437    22.7s
    arrayops       |     2031                    2      2033  3m22.4s
    mpfr           |     1135                    1      1136    31.2s
    regex          |      130                            130     5.9s
    sysinfo        |        4                              4     0.5s
    env            |       94                             94     1.2s
    combinatorics  |      170                            170    19.7s
    abstractarray  |    55170                24795     79965  3m32.1s
    mod2pi         |       80                             80     1.3s
    rounding       |   112720                         112720    29.1s
    client         |        2     3                        5     6.7s
    numbers        |  1578757     1              2   1578760  4m40.3s
    errorshow      |      224     8                      232    30.2s
    goto           |       19                             19     6.9s
    llvmcall2      |        7                              7     1.2s
    iterators      |    10164                          10164  3m53.6s
    ryu            |    31215                          31215     8.8s
    some           |       72                             72     3.1s
    meta           |       67     1      1                69     6.4s
    sorting        |    16096                   10     16106  3m33.7s
    stacktraces    |       48                             48     6.5s
    sets           |     3594                    1      3595    51.3s
    float16        |   762093                         762093  2m06.1s
    docs           |      238                            238    11.1s
    broadcast      |      509     2                      511  2m36.4s
    enums          |       99                             99     7.7s
    subarray       |   318316                         318316  5m54.5s
    interpreter    |        3                              3     3.2s
    binaryplatforms |      341                            341    16.8s
    bitset         |      195                            195     4.7s
    checked        |     1239                           1239    10.5s
    atexit         |       40                             40    24.4s
    error          |       31                             31     3.2s
    osutils        |       57                             57     0.5s
    floatfuncs     |      215                            215    13.3s
    iostream       |       50                             50     2.9s
    show           |   128877     1      1       8    128887  2m11.0s
    secretbuffer   |       27                             27     1.5s
    specificity    |      175                            175     2.2s
    boundscheck    |                                    None    17.6s
    cartesian      |      343                    3       346    18.6s
    syntax         |     1521     5      7       1      1534    24.7s
    corelogging    |      231                            231    23.1s
    reinterpretarray |      232                            232    29.1s
    smallarrayshrink |       36                             36     0.4s
    opaque_closure |       29     4      8       1        42     2.9s
    filesystem     |        4                              4     5.4s
    read           |     3870                           3870  4m04.3s
    missing        |      564     1              1       566    34.5s
    asyncmap       |      304                            304    20.4s
    download       |                                    None    24.1s
    int            |   524698                         524698  1m44.0s
    channels       |      258                            258  1m28.0s
    bitarray       |   911306                         911306  6m34.9s
    loading        |   151956     3     11            151970  6m11.1s
    misc           |  1279391            1           1279392  2m32.8s
    ranges         | 12110579     2         327682  12438263  4m25.6s
    euler          |       12                             12  4m50.9s
    cmdlineargs    |      255                    3       258  3m35.1s
    precompile     |                     1                 1
    threads        |                     1                 1
    stress         |                     1                 1
    FAILURE

The global RNG seed was 0x290773642ea131468038451fae7e75d6.
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
