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

Julia 1.8.0-DEV on Windows for a time budget of 1000 ns per call site:

```
Test Summary:      |     Pass  Error  Broken     Total     Time
  Overall          | 12768420      2  352557  13120979  8m45.5s
    triplequote    |       29                       29     4.2s
    unicode/utf8   |       19                       19     4.9s
    worlds         |       43                       43     5.9s
    char           |     1628                     1628     7.5s
    iobuffer       |      209                      209     3.5s
    intrinsics     |      301                      301    10.1s
    keywordargs    |      147                      147    13.2s
    staged         |       64                       64     5.9s
    ambiguous      |       95              2        97    14.8s
    tuple          |      625                      625    14.5s
    hashing        |    12519                    12519    31.0s
    atomics        |     3444                     3444    38.2s
    simdloop       |      240                      240     5.1s
    reduce         |     8582                     8582    38.7s
    vecelement     |      678                      678    19.9s
    intfuncs       |   227981                   227981    41.0s
    offsetarray    |      477              3       480  1m09.5s
    copy           |      533                      533     5.6s
    subtype        |   337668             19    337687  1m25.4s
    fastmath       |      946                      946    15.4s
    functional     |       98                       98    13.3s
    rational       |    98639              1     98640    54.0s
    ordering       |       37                       37     4.8s
    reducedim      |      865                      865  1m37.5s
    path           |     1051             12      1063     2.7s
    operators      |    13040                    13040    15.8s
    parse          |    16098                    16098     6.3s
    gmp            |     2357                     2357     7.6s
    ccall          |     3998                     3998    55.0s
    dict           |   144420                   144420  3m01.5s
    backtrace      |       18                       18     6.1s
    exceptions     |       46                       46     0.6s
    arrayops       |     2031              2      2033  3m04.0s
    math           |   148979                   148979  1m59.5s
    version        |     2452                     2452     2.1s
    namedtuple     |      215                      215     5.8s
    core           |    55154              1     55155  3m29.7s
    file           |      351                      351    17.7s
    spawn          |      231              4       235    43.8s
    floatapprox    |       49                       49     3.3s
    abstractarray  |    55241          24795     80036  3m13.3s
    mpfr           |     1135              1      1136    16.4s
    reflection     |      411                      411     9.6s
    broadcast      |       72      1                73    16.3s
    complex        |     8432              5      8437    19.1s
    sysinfo        |        4                        4     0.4s
    env            |       94                       94     1.2s
    regex          |      130                      130    17.7s
    combinatorics  |      170                      170    15.6s
    mod2pi         |       80                       80     1.6s
    euler          |       12                       12     2.4s
    client         |        2                        2     1.9s
    rounding       |   112720                   112720    14.9s
    errorshow      |      210      1               211    13.0s
    goto           |       19                       19     6.2s
    llvmcall2      |        7                        7     1.4s
    ryu            |    31215                    31215    10.4s
    some           |       72                       72     2.3s
    numbers        |  1578757              2   1578759  4m45.9s
    sets           |     3592              1      3593    42.3s
    stacktraces    |       21                       21     3.0s
    meta           |       66                       66     4.7s
    docs           |      233                      233     9.3s
    binaryplatforms |      341                      341    15.3s
    enums          |       98                       98     5.7s
    iterators      |    10164                    10164  3m40.2s
    atexit         |       40                       40    22.9s
    sorting        |    16096             10     16106  3m15.1s
    interpreter    |        3                        3     2.5s
    bitset         |      195                      195     2.6s
    checked        |     1239                     1239     2.9s
    subarray       |   318316                   318316  5m31.1s
    error          |       31                       31     2.8s
    floatfuncs     |      215                      215    11.5s
    osutils        |       57                       57     0.2s
    boundscheck    |                              None    18.0s
    iostream       |       50                       50     2.9s
    secretbuffer   |       27                       27     2.3s
    cartesian      |      343              3       346    16.9s
    specificity    |      175                      175     1.8s
    float16        |   762093                   762093  2m17.6s
    syntax         |     1479              1      1480    20.8s
    corelogging    |      214                      214    11.9s
    read           |     3725                     3725  3m00.4s
    smallarrayshrink |       36                       36     0.4s
    opaque_closure |       11              1        12     1.6s
    reinterpretarray |      232                      232    26.4s
    filesystem     |        4                        4     0.8s
    show           |   128870              8    128878  2m23.4s
    asyncmap       |      304                      304    19.8s
    download       |                              None    24.2s
    missing        |      564              1       565    30.5s
    channels       |      230                      230  1m27.7s
    ranges         |  5786623         327682   6114305  3m15.5s
    loading        |   137632                   137632  5m20.3s
    int            |   524698                   524698  2m06.7s
    bitarray       |   912730                   912730  6m28.9s
    misc           |  1282145                  1282145  2m46.9s
    cmdlineargs    |      255              3       258  3m33.6s
    precompile     |      123                      123    28.2s
    threads        |       10                       10  1m30.3s
    stress         |                              None     0.0s
    FAILURE

The global RNG seed was 0x6047a78b82ee19042ef7dcec5e875545.
```

Known failing tests are deactivated.

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
