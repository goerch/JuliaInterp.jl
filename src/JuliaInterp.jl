module JuliaInterp

include("types.jl")
include("lower.jl")
include("ast.jl")

function include(mod::Module, path, debug=false, budget=UInt64(1000))
    code = read(path, String)
    tls = task_local_storage()
    prev = haskey(tls, :SOURCE_PATH) ? tls[:SOURCE_PATH] : nothing
    tls[:SOURCE_PATH] = path
    try
        ast = Meta.parseall(code, filename=path)
        expr = quote
            using Test, Random, Distributed
            eval(p) = Core.eval($mod, p)
            include(x) = Base.include($mod, x)
            $ast
        end
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
