function eval_ast(interpstate, expr)
    interpstate.debug && @show :eval_ast expr
    try
        ans = @eval last(interpstate.mods).mod $expr
        interpstate.debug && @show ans
        ans
    catch exception
        if !isa(exception, AssertionError)
            interpstate.debug && @show :eval_ast expr exception
        end
        rethrow(exception)
    end
end

function eval_ast_lower(interpstate, expr)
    interpstate.debug && @show :eval_ast_lower expr
    try
        lwr = Meta.lower(last(interpstate.mods).mod, expr)
        if lwr.head == :thunk
            ans = interprete_lower(interpstate, nothing, lwr.args[1])
        else
            ans = @eval last(interpstate.mods).mod $expr
        end
        interpstate.debug && @show ans
        ans
    catch exception
        if !isa(exception, AssertionError)
            interpstate.debug && @show :eval_ast_lower expr exception
        end
        rethrow(exception)
    end
end

function interprete_ast(interpstate, ::Val{:comparison}, args)
    interpstate.debug && @show :comparison args
    expr = Expr(:comparison, args...)
    eval_ast_lower(interpstate, expr)
end

function interprete_ast(interpstate, ::Val{:(||)}, args)
    interpstate.debug && @show :(||) args
    expr = Expr(:(||), args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:(&&)}, args)
    interpstate.debug && @show :(&&) args
    expr = Expr(:(&&), args...)
    eval_ast_lower(interpstate, expr)
end

function interprete_ast(interpstate, ::Val{:primitive}, args)
    interpstate.debug && @show :primitive args
    expr = Expr(:primitive, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:call}, args)
    interpstate.debug && @show :call args
    expr = Expr(:call, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:macrocall}, args)
    interpstate.debug && @show :macrocall args
    expr = Expr(:macrocall, args...) 
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:(.=)}, args)
    interpstate.debug && @show :(.=) args
    expr = Expr(:(.=), args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:(=)}, args)
    interpstate.debug && @show :(=) args
    expr = Expr(:(=), args...) 
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:const}, args)
    interpstate.debug && @show :const args
    expr = Expr(:const, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:local}, args)
    interpstate.debug && @show :local args
    expr = Expr(:local, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:global}, args)
    interpstate.debug && @show :global args
    expr = Expr(:global, args...) 
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:let}, args)
    interpstate.debug && @show :let args
    expr = Expr(:let, args...) 
    eval_ast(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:block}, args)
    interpstate.debug && @show :block args
    for arg in args
        interprete_ast(interpstate, arg)
    end
end
function interprete_ast(interpstate, ::Val{:try}, args)
    interpstate.debug && @show :try args
    expr = Expr(:try, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:do}, args)
    interpstate.debug && @show :do args
    expr = Expr(:do, args...) 
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:if}, args)
    interpstate.debug && @show :if args
    expr = Expr(:if, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:for}, args)
    interpstate.debug && @show :for args
    expr = Expr(:for, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:while}, args)
    interpstate.debug && @show :while args
    expr = Expr(:while, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:function}, args)
    interpstate.debug && @show :function args
    expr = Expr(:function, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:where}, args)
    interpstate.debug && @show :function args
    expr = Expr(:where, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:macro}, args)
    interpstate.debug && @show :macro args
    expr = Expr(:macro, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:struct}, args)
    interpstate.debug && @show :struct args
    expr = Expr(:struct, args...)
    eval_ast(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:curly}, args)
    interpstate.debug && @show :curly args
    expr = Expr(:curly, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:abstract}, args)
    interpstate.debug && @show :abstract args
    expr = Expr(:abstract, args...)
    eval_ast(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:using}, args)
    interpstate.debug && @show :using args
    expr = Expr(:using, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:import}, args)
    interpstate.debug && @show :import args
    expr = Expr(:import, args...)
    eval_ast_lower(interpstate, expr)
end
function interprete_ast(interpstate, ::Val{:export}, args)
    interpstate.debug && @show :export args
    expr = Expr(:export, args...)
    eval_ast_lower(interpstate, expr)
end

function interprete_ast(interpstate, ::Val{:toplevel}, args)
    interpstate.debug && @show :toplevel args
    for arg in args
        interprete_ast(interpstate, arg)
    end
end 
function interprete_ast(interpstate, ::Val{:module}, args)
    interpstate.debug && @show :module args
    expr = Expr(:module, args...)
    eval_ast_lower(interpstate, expr)
end

function interprete_ast(interpstate, node)
    node
end
function interprete_ast(interpstate, expr::Expr)
    interpstate.debug && @show :expr
    interprete_ast(interpstate, Val(expr.head), expr.args)
end 

function interprete_ast(mod::Module, expr::Expr)
    interpstate = InterpState(false, 1, [ModuleState(mod)])
    ans = interprete_ast(interpstate, expr)
    pop!(interpstate.mods)
    ans
end 