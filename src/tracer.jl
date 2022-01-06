using Test, Random, Distributed, Compat, JuliaInterp

function builtins()
    ids = []
    for mod in (Base, Core)
    # for mod in (Core,)
        ids = vcat(ids, 
            ((mod, name) for name in names(mod; all=true)
                if isdefined(mod, name) &&
                   getfield(mod, name) isa Core.Builtin)...)
    end
    ids
end

function intrinsics()
    ids = []
    for mod in (Base, Core)
    # for mod in (Core,)
        ids = vcat(ids, 
            ((mod, name) for name in names(mod; all=true)
                if isdefined(mod, name) &&
                   getfield(mod, name) isa Core.IntrinsicFunction)...)
    end
    ids
end

function tracer(files)
    dir = "C:/Users/Win10/AppData/Local/Programs/Julia-1.8.0-DEV/share/julia/test"
    home = pwd()
    cd(dir)
    try
        for file in files
            try
                mod = @eval Main (module IsolatedTests using Base, Test, Random, Distributed, Compat, JuliaInterp; end)
                @testset verbose=true begin
                    JuliaInterp.include(mod, file, true, UInt(1_000_000_000_000))
                end
            catch exception
                @show :toplevel exception
                rethrow()
            end
        end
    finally
        cd(home)
    end
end
