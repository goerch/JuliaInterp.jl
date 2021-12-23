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
  Overall          | 21450699    61     47  352561  21803368  10m45.9s
    unicode/utf8   |       19                             19      5.5s
    strings/io     |    12764                          12764      9.9s
    strings/search |      876                            876     10.5s
    keywordargs    |      149     2                      151     14.2s
    char           |     1628                           1628      4.4s
    strings/util   |     1147                           1147     14.9s
    triplequote    |       29                             29      0.2s
    worlds         |       81     2      1                84     15.1s
    ambiguous      |      107                    2       109     18.4s
    intrinsics     |      301                            301      7.2s
    core           |      561     3      1       1       566     26.5s
    strings/basic  |    87674                          87674     26.8s
    staged         |       64                             64      6.4s
    iobuffer       |      209                            209     11.0s
    atomics        |     3444                           3444     36.1s
    tuple          |      625                            625     14.6s
    hashing        |    12519                          12519     35.9s
    simdloop       |      240                            240      6.1s
    reduce         |     8580     2                     8582     42.3s
    vecelement     |      678                            678     18.9s
    intfuncs       |   227882                         227882     38.3s
    subtype        |   337674                   19    337693   1m18.2s
    copy           |      533                            533     13.6s
    offsetarray    |      477    10              3       490   1m18.9s
    fastmath       |      945     1                      946     16.9s
    rational       |    98639                    1     98640     54.3s
    functional     |       97            1                98     20.3s
    reducedim      |      865                            865   1m48.4s
    path           |     1051                   12      1063      3.3s
    operators      |    13040                          13040     14.0s
    ordering       |       37                             37     10.2s
    parse          |    16098                          16098      6.4s
    gmp            |     2357                           2357      7.8s
    numbers        |  1578757     1              2   1578760   2m54.0s
    dict           |   144420                         144420   2m49.8s
    backtrace      |       23     4      9       1        37     14.3s
    ccall          |     1805     1      1              1807   1m01.0s
    math           |   148979                         148979   2m01.6s
    file           |        5            1                 6      2.4s
    exceptions     |       65     4      1                70      8.5s
    spawn          |      231     1              4       236     35.5s
    version        |     2452                           2452      7.0s
    arrayops       |     2031                    2      2033   3m22.7s
    strings/types  |  2302691                        2302691   3m57.1s
    abstractarray  |    56352                24795     81147   3m21.7s
    namedtuple     |      215                            215     12.1s
    floatapprox    |       49                             49      4.5s
    regex          |      130                            130      5.0s
    mpfr           |     1135                    1      1136     21.8s
    sysinfo        |        4                              4      0.3s
    env            |       94                             94      1.1s
    complex        |     8432                    5      8437     26.2s
    combinatorics  |      170                            170     15.5s
    mod2pi         |       80                             80      1.2s
    reflection     |      203            1               204     27.1s
    rounding       |   112720                         112720     14.7s
    client         |        2     3                        5     11.0s
    errorshow      |      143     2      1               146     19.4s
    subarray       |   318316                         318316   5m40.5s
    goto           |       19                             19      0.5s
    llvmcall2      |        7                              7      0.7s
    ryu            |    31215                          31215      7.6s
    some           |       72                             72      1.9s
    float16        |   762093                         762093   1m51.2s
    meta           |       69                             69      4.0s
    iterators      |    10164                          10164   3m56.2s
    stacktraces    |       37     7      4                48      7.7s
    docs           |      238                            238      9.5s
    sorting        |    16096                   10     16106   3m26.2s
    sets           |     3594                    1      3595     50.7s
    atexit         |       40                             40     12.4s
    binaryplatforms |      341                            341     15.9s
    enums          |       99                             99     14.1s
    interpreter    |        3                              3      2.5s
    checked        |     1239                           1239      5.0s
    broadcast      |      509     2                      511   2m36.2s
    bitset         |      195                            195      4.7s
    show           |   128879                    8    128887   2m04.9s
    error          |       31                             31      2.7s
    floatfuncs     |      215                            215     13.4s
    osutils        |       57                             57      5.9s
    boundscheck    |                                    None     17.0s
    iostream       |       50                             50      5.2s
    secretbuffer   |       27                             27      1.8s
    read           |     3870                           3870   3m13.9s
    specificity    |      175                            175      3.2s
    cartesian      |      343                    3       346     16.6s
    corelogging    |      231                            231     16.4s
    reinterpretarray |      232                            232     24.9s
    syntax         |     1518     5     10       1      1534     22.8s
    smallarrayshrink |       36                             36      0.2s
    opaque_closure |       32     5      4       1        42      2.0s
    filesystem     |        4                              4      4.6s
    missing        |      564     1              1       566     34.3s
    asyncmap       |      304                            304     20.8s
    download       |                                    None     24.1s
    int            |   524698                         524698   1m37.1s
    channels       |      258                            258   1m23.2s
    loading        |   147000     3     11            147014   5m43.4s
    bitarray       |   914874                         914874   6m57.1s
    misc           |  1279391            1           1279392   2m50.3s
    euler          |       12                             12   4m46.9s
    cmdlineargs    |      255                    3       258   3m34.0s
    ranges         | 12110586     2         327682  12438270   6m23.3s
    precompile     |      123                            123     28.1s
    threads        |       10                    3        13   1m38.1s
    stress         |                                    None      0.0s
    FAILURE

The global RNG seed was 0xd5c060f5b5710ae8684342fc63d6629e.
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
