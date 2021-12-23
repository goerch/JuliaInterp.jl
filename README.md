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
  Overall          | 21459457    50     33  352561  21812101  9m02.4s
    unicode/utf8   |       19                             19     4.8s
    strings/io     |    12764                          12764     9.5s
    strings/types  |  2302691                        2302691    10.2s
    strings/search |      876                            876    10.3s
    triplequote    |       29                             29     0.2s
    char           |     1628                           1628     3.4s
    strings/util   |     1147                           1147    14.0s
    keywordargs    |      148     3                      151    14.5s
    worlds         |       83            1                84    15.0s
    ambiguous      |      107                    2       109    16.8s
    intrinsics     |      301                            301     7.2s
    strings/basic  |    87674                          87674    19.2s
    iobuffer       |      209                            209     4.1s
    staged         |       64                             64     6.1s
    atomics        |     3444                           3444    34.7s
    tuple          |      625                            625    21.2s
    hashing        |    12519                          12519    33.9s
    simdloop       |      240                            240     6.6s
    reduce         |     8582                           8582    40.5s
    subtype        |   337673     1             19    337693    59.2s
    intfuncs       |   227880                         227880    38.2s
    core           |      563     1      1       1       566  1m26.6s
    copy           |      533                            533     5.7s
    vecelement     |      678                            678    35.4s
    offsetarray    |      477    10              3       490  1m12.8s
    fastmath       |      945     1                      946    16.2s
    functional     |       98                             98    19.0s
    rational       |    98639                    1     98640    52.2s
    path           |     1051                   12      1063     2.6s
    ordering       |       37                             37    10.2s
    operators      |    13040                          13040    16.2s
    parse          |    16098                          16098     9.3s
    reducedim      |      865                            865  1m47.7s
    gmp            |     2357                           2357     9.7s
    numbers        |  1578757     1              2   1578760  2m53.8s
    spawn          |      231     1              4       236    36.7s
    ccall          |     1806            1              1807  1m00.9s
    dict           |   144420                         144420  2m48.6s
    backtrace      |       38                    1        39     4.0s
    file           |        5            1                 6     2.1s
    exceptions     |       65     4      1                70     8.2s
    version        |     2452                           2452     7.1s
    math           |   148979                         148979  1m58.5s
    namedtuple     |      215                            215    12.5s
    arrayops       |     2031                    2      2033  3m15.8s
    floatapprox    |       49                             49     4.4s
    regex          |      130                            130     4.8s
    mpfr           |     1135                    1      1136    22.8s
    reflection     |      414            2               416    12.5s
    complex        |     8432                    5      8437    26.2s
    sysinfo        |        4                              4     0.4s
    abstractarray  |    55318                24795     80113  3m22.0s
    env            |       94                             94     2.0s
    mod2pi         |       80                             80     1.0s
    euler          |       12                             12     2.1s
    combinatorics  |      170                            170    16.0s
    client         |        2     3                        5     5.6s
    rounding       |   112720                         112720    31.9s
    errorshow      |      224     8                      232    25.6s
    goto           |       19                             19     5.6s
    llvmcall2      |        7                              7     1.0s
    ryu            |    31215                          31215     8.4s
    some           |       72                             72     2.2s
    sets           |     3594                    1      3595    42.9s
    meta           |       69                             69     4.2s
    stacktraces    |       48                             48     6.0s
    docs           |      238                            238     9.1s
    iterators      |    10164                          10164  3m50.0s
    binaryplatforms |      341                            341    14.4s
    subarray       |   318316                         318316  5m37.7s
    float16        |   762093                         762093  1m55.4s
    enums          |       99                             99     6.7s
    interpreter    |        3                              3     2.5s
    atexit         |       40                             40    13.2s
    sorting        |    16096                   10     16106  3m30.4s
    checked        |     1239                           1239     4.1s
    bitset         |      195                            195     4.4s
    error          |       31                             31     2.6s
    floatfuncs     |      215                            215    12.9s
    osutils        |       57                             57     0.3s
    broadcast      |      509     2                      511  2m35.4s
    boundscheck    |                                    None    16.8s
    show           |   128879                    8    128887  2m05.3s
    secretbuffer   |       27                             27     1.4s
    cartesian      |      343                    3       346    16.7s
    iostream       |       50                             50     3.2s
    specificity    |      175                            175     2.0s
    read           |     3870                           3870  2m59.0s
    corelogging    |      231                            231    13.3s
    smallarrayshrink |       36                             36     0.2s
    opaque_closure |       31     4      6       1        42     2.2s
    asyncmap       |      304                            304    22.5s
    filesystem     |        4                              4     0.4s
    reinterpretarray |      232                            232    26.0s
    syntax         |     1520     5      8       1      1534    28.9s
    missing        |      564     1              1       566    32.0s
    download       |                                    None    24.3s
    int            |   524698                         524698  1m20.4s
    channels       |      258                            258  1m19.6s
    bitarray       |   913634                         913634  6m17.6s
    misc           |  1279391            1           1279392  2m26.0s
    loading        |   157692     3     11            157706  5m34.7s
    ranges         | 12110603     2         327682  12438287  3m58.7s
    cmdlineargs    |      255                    3       258  3m24.2s
    precompile     |      123                            123    28.1s
    threads        |       10                    3        13  1m35.3s
    stress         |                                    None     0.0s
    FAILURE

The global RNG seed was 0x6158a444e74b894949fef96e99a1e130.
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
