function eval_ast(interpstate, mod, expr)
    interpstate.options.debug && @show :eval_ast mod expr
    try
        # ans = Core.eval(mod, expr)
        ans = @eval mod $expr
        interpstate.options.debug && @show :eval_ast ans
        return ans
    catch exception
        interpstate.options.debug && @show :eval_ast mod expr exception
        rethrow()
    end
end

function eval_lower_ast(interpstate, mod, expr)
    interpstate.options.debug && @show :eval_lower_ast mod expr
    try
        lwr = Meta.lower(mod, expr)
        if lwr.head == :thunk
            ans = interpret_lower(interpstate, mod, lwr.args[1])
        else
            # ans = Core.eval(mod, expr)
            ans = @eval mod $expr
        end
        interpstate.options.debug && @show :eval_lower_ast ans
        return ans
    catch exception
        interpstate.options.debug && @show :eval_lower_ast mod expr exception
        rethrow()
    end
end

function interpret_ast_expr(interpstate, mod, ::Val{:comparison}, args)
    interpstate.options.debug && @show mod :comparison args
    expr = Expr(:comparison, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate, mod, ::Val{:(||)}, args)
    interpstate.options.debug && @show mod :(||) args
    expr = Expr(:(||), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:(&&)}, args)
    interpstate.options.debug && @show mod :(&&) args
    expr = Expr(:(&&), args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate, mod, ::Val{:primitive}, args)
    interpstate.options.debug && @show mod :primitive args
    expr = Expr(:primitive, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:call}, args)
    interpstate.options.debug && @show mod :call args
    expr = Expr(:call, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:macrocall}, args)
    interpstate.options.debug && @show mod :macrocall args
    expr = Expr(:macrocall, args...) 
    # Macros be better handled by the compiler?
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:(.=)}, args)
    interpstate.options.debug && @show mod :(.=) args
    expr = Expr(:(.=), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:(=)}, args)
    interpstate.options.debug && @show mod :(=) args
    expr = Expr(:(=), args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:const}, args)
    interpstate.options.debug && @show mod :const args
    expr = Expr(:const, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:local}, args)
    interpstate.options.debug && @show mod :local args
    expr = Expr(:local, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:global}, args)
    interpstate.options.debug && @show mod :global args
    expr = Expr(:global, args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:let}, args)
    interpstate.options.debug && @show mod :let args
    expr = Expr(:let, args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:block}, args)
    interpstate.options.debug && @show mod :block args
    local ans
    for arg in args
        ans = interpret_ast_node(interpstate, mod, arg)
    end
    ans
end
function interpret_ast_expr(interpstate, mod, ::Val{:try}, args)
    interpstate.options.debug && @show mod :try args
    expr = Expr(:try, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:do}, args)
    interpstate.options.debug && @show mod :do args
    expr = Expr(:do, args...) 
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:if}, args)
    interpstate.options.debug && @show mod :if args
    expr = Expr(:if, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:for}, args)
    interpstate.options.debug && @show mod :for args
    expr = Expr(:for, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:while}, args)
    interpstate.options.debug && @show mod :while args
    expr = Expr(:while, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:function}, args)
    interpstate.options.debug && @show mod :function args
    expr = Expr(:function, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:where}, args)
    interpstate.options.debug && @show mod :function args
    expr = Expr(:where, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:macro}, args)
    interpstate.options.debug && @show mod :macro args
    expr = Expr(:macro, args...)
    # Macros be better handled by the compiler?
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:struct}, args)
    interpstate.options.debug && @show mod :struct args
    expr = Expr(:struct, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:curly}, args)
    interpstate.options.debug && @show mod :curly args
    expr = Expr(:curly, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:abstract}, args)
    interpstate.options.debug && @show mod :abstract args
    expr = Expr(:abstract, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:using}, args)
    interpstate.options.debug && @show mod :using args
    expr = Expr(:using, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:import}, args)
    interpstate.options.debug && @show mod :import args
    expr = Expr(:import, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_expr(interpstate, mod, ::Val{:export}, args)
    interpstate.options.debug && @show mod :export args
    expr = Expr(:export, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate, mod, ::Val{:error}, args)
    @show mod :error args
end 
function interpret_ast_expr(interpstate, mod, ::Val{:incomplete}, args)
    @show mod :incomplete args
end 
function interpret_ast_expr(interpstate, mod, ::Val{:toplevel}, args)
    interpstate.options.debug && @show mod :toplevel args
    local ans
    for arg in args
        ans = interpret_ast_node(interpstate, mod, arg)
    end
    ans
end 
function interpret_ast_expr(interpstate, mod, ::Val{:module}, args)
    interpstate.options.debug && @show mod :module args
    expr = Expr(:module, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_node(interpstate, mod, node)
    node
end
function interpret_ast_node(interpstate, mod, expr::Expr)
    interpret_ast_expr(interpstate, mod, Val(expr.head), expr.args)
end 

function interpret_ast(mod, expr, options)
    interpstate = interp_state(mod, options)
    interpret_ast_node(interpstate, mod, expr)
end 
