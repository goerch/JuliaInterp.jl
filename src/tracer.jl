using Test, Random, Distributed, Compat, JuliaInterp

function tracer(files)
    dir = "C:/Users/Win10/AppData/Local/Programs/Julia-1.8.0-DEV/share/julia/test"
    home = pwd()
    cd(dir)
    try
        for file in files
            try
                mod = @eval Main (module IsolatedTests using Base, Test, Random, Distributed, Compat, JuliaInterp; end)
                options = JuliaInterp.options(false, true, [Test, mod], [Base], UInt(1_000_000))
                @testset verbose=true begin
                    JuliaInterp.include(mod::Module, file, options)
                end
            catch exception
                @show :toplevel exception
                rethrow()
            end
        end
    finally
        cd(home)
    end
    Module
end
