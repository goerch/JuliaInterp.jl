module JuliaInterp

using Compat, Random

include("types.jl")
include("lower.jl")
include("ast.jl")

function include(mod, path, debug=false, budget=UInt64(10))
    code = read(path, String)
    tls = task_local_storage()
    prev = haskey(tls, :SOURCE_PATH) ? tls[:SOURCE_PATH] : nothing
    tls[:SOURCE_PATH] = path
    try
        expr = Meta.parseall(code, filename=path)
        interpret_ast(mod, expr, debug, budget)
    finally
        if prev === nothing
            delete!(tls, :SOURCE_PATH)
        else
            tls[:SOURCE_PATH] = prev
        end
    end
end

end
