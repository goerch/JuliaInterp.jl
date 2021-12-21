using Profile
Profile.clear()
# include("tracer.jl")
@profile include("tracer.jl")
# Profile.print()
Juno.profiler()
