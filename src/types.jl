struct ModuleState
    mod::Module
end

mutable struct InterpState
    debug::Bool
    depth::Int
    mods::Vector{ModuleState}
end

mutable struct CodeState
    interpstate::InterpState
    pc::Int
    ssavalues::Vector
    slots::Vector
    handlers::Vector{Int}
    exceptions::Vector{Exception}
end
