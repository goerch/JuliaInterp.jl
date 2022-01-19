module JuliaInterp

using Compat, Random

include("types.jl")
include("lower.jl")
include("ast.jl")

function include(mod, path, options)
    code = read(path, String)
    tls = task_local_storage()
    prev = get(tls, :SOURCE_PATH, nothing)
    tls[:SOURCE_PATH] = path
    try
        expr::Expr = Meta.parseall(code, filename=path)
        interpret_ast(mod, expr, options)
    finally
        if prev === nothing
            delete!(tls, :SOURCE_PATH)
        else
            tls[:SOURCE_PATH] = prev
        end
    end
end

end
