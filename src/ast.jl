function eval_ast(interpstate, mod, expr)
    interpstate.debug && @show :eval_ast mod expr
    try
        # ans = Core.eval(mod, expr)
        ans = @eval mod $expr
        interpstate.debug && @show :eval_ast ans
        return ans
    catch exception
        interpstate.debug && @show :eval_ast expr exception
        rethrow()
    end
end

function eval_lower_ast(interpstate, mod, expr)
    interpstate.debug && @show :eval_lower_ast mod expr
    try
        lwr = Meta.lower(mod, expr)
        if lwr.head == :thunk
            ans = interpret_lower(interpstate, mod, lwr.args[1])
        else
            # ans = Core.eval(mod, expr)
            ans = @eval mod $expr
        end
        interpstate.debug && @show :eval_lower_ast ans
        return ans
    catch exception
        interpstate.debug && @show :eval_lower_ast expr exception
        rethrow()
    end
end

function interpret_ast_expr(interpstate, mod, ::Val{:comparison}, args)
    interpstate.debug && @show :comparison args
    expr = Expr(:comparison, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate, mod, ::Val{:(||)}, args)
    interpstate.debug && @show :(||) args
    expr = Expr(:(||), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:(&&)}, args)
    interpstate.debug && @show :(&&) args
    expr = Expr(:(&&), args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate, mod, ::Val{:primitive}, args)
    interpstate.debug && @show :primitive args
    expr = Expr(:primitive, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:call}, args)
    interpstate.debug && @show :call args
    expr = Expr(:call, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:macrocall}, args)
    interpstate.debug && @show :macrocall args
    expr = Expr(:macrocall, args...) 
    # Macros be better handled by the compiler?
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:(.=)}, args)
    interpstate.debug && @show :(.=) args
    expr = Expr(:(.=), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:(=)}, args)
    interpstate.debug && @show :(=) args
    expr = Expr(:(=), args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:const}, args)
    interpstate.debug && @show :const args
    expr = Expr(:const, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:local}, args)
    interpstate.debug && @show :local args
    expr = Expr(:local, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:global}, args)
    interpstate.debug && @show :global args
    expr = Expr(:global, args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:let}, args)
    interpstate.debug && @show :let args
    expr = Expr(:let, args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:block}, args)
    interpstate.debug && @show :block args
    local ans
    for arg in args
        ans = interpret_ast_node(interpstate, mod, arg)
    end
    ans
end
function interpret_ast_expr(interpstate, mod, ::Val{:try}, args)
    interpstate.debug && @show :try args
    expr = Expr(:try, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:do}, args)
    interpstate.debug && @show :do args
    expr = Expr(:do, args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:if}, args)
    interpstate.debug && @show :if args
    expr = Expr(:if, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:for}, args)
    interpstate.debug && @show :for args
    expr = Expr(:for, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:while}, args)
    interpstate.debug && @show :while args
    expr = Expr(:while, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:function}, args)
    interpstate.debug && @show :function args
    expr = Expr(:function, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:where}, args)
    interpstate.debug && @show :function args
    expr = Expr(:where, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:macro}, args)
    interpstate.debug && @show :macro args
    expr = Expr(:macro, args...)
    # Macros be better handled by the compiler?
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:struct}, args)
    interpstate.debug && @show :struct args
    expr = Expr(:struct, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:curly}, args)
    interpstate.debug && @show :curly args
    expr = Expr(:curly, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:abstract}, args)
    interpstate.debug && @show :abstract args
    expr = Expr(:abstract, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:using}, args)
    interpstate.debug && @show :using args
    expr = Expr(:using, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:import}, args)
    interpstate.debug && @show :import args
    expr = Expr(:import, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:export}, args)
    interpstate.debug && @show :export args
    expr = Expr(:export, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate, mod, ::Val{:error}, args)
    @show :error args
end 
function interpret_ast_expr(interpstate, mod, ::Val{:incomplete}, args)
    @show :incomplete args
end 
function interpret_ast_expr(interpstate, mod, ::Val{:toplevel}, args)
    interpstate.debug && @show :toplevel args
    local ans
    for arg in args
        ans = interpret_ast_node(interpstate, mod, arg)
    end
    ans
end 
function interpret_ast_expr(interpstate, mod, ::Val{:module}, args)
    interpstate.debug && @show :module args
    expr = Expr(:module, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_node(interpstate, mod, node)
    node
end
function interpret_ast_node(interpstate, mod, expr::Expr)
    interpret_ast_expr(interpstate, mod, Val(expr.head), expr.args)
end 

function interpret_ast(mod, expr, debug, budget)
    interpstate = interp_state(debug, budget, mod)
    interpret_ast_node(interpstate, mod, expr)
end 
