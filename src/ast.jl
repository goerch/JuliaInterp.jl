function eval_ast(interpstate::InterpState, mod, expr)
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

function eval_lower_ast(interpstate::InterpState, mod, expr)
    interpstate.options.debug && @show :eval_lower_ast mod expr
    try
        lwr = Meta.lower(mod, expr)::Expr
        if lwr.head == :thunk
            ans = interpret_lower(interpstate, mod, lwr.args[1]::Core.CodeInfo)
        else
            @show lwr mod expr
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

function interpret_ast_comparison(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :comparison args
    expr = Expr(:comparison, args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_or(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :(||) args
    expr = Expr(:(||), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_and(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :(&&) args
    expr = Expr(:(&&), args...)
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_primitive(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :primitive args
    expr = Expr(:primitive, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_call(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :call args
    expr = Expr(:call, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_macrocall(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :macrocall args
    expr = Expr(:macrocall, args...)
    # Macros be better handled by the compiler?
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_broadcast(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :(.=) args
    expr = Expr(:(.=), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_assign(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :(=) args
    expr = Expr(:(=), args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_const(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :const args
    expr = Expr(:const, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_local(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :local args
    expr = Expr(:local, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_global(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :global args
    expr = Expr(:global, args...)
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_let(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :let args
    expr = Expr(:let, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_block(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :block args
    local linenumbernode
    try
        local ans
        for arg in args
            ans = interpret_ast_node(interpstate, mod, arg)
            if ans isa LineNumberNode
                linenumbernode = ans
            end
        end
        ans            
    catch 
        @show linenumbernode
        rethrow()
    end
end
function interpret_ast_try(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :try args
    expr = Expr(:try, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_do(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :do args
    expr = Expr(:do, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_if(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :if args
    expr = Expr(:if, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_for(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :for args
    expr = Expr(:for, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_while(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :while args
    expr = Expr(:while, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_function(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :function args
    expr = Expr(:function, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_where(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :function args
    expr = Expr(:where, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_macro(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :macro args
    expr = Expr(:macro, args...)
    # Macros be better handled by the compiler?
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_struct(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :struct args
    expr = Expr(:struct, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_curly(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :curly args
    expr = Expr(:curly, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_abstract(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :abstract args
    expr = Expr(:abstract, args...)
    eval_lower_ast(interpstate, mod, expr)
end
function interpret_ast_using(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :using args
    expr = Expr(:using, args...)
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_import(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :import args
    expr = Expr(:import, args...)
    eval_ast(interpstate, mod, expr)
end
function interpret_ast_export(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :export args
    expr = Expr(:export, args...)
    # Can we really lower exports?
    eval_lower_ast(interpstate, mod, expr)
end

function interpret_ast_error(interpstate::InterpState, mod, args)
    @show mod :error args
end
function interpret_ast_incomplete(interpstate, mod, args)
    @show mod :incomplete args
end
function interpret_ast_toplevel(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :toplevel args
    local linenumbernode
    try
        local ans
        for arg in args
            ans = interpret_ast_node(interpstate, mod, arg)
            if ans isa LineNumberNode
                linenumbernode = ans
            end
        end
        ans            
    catch 
        @show linenumbernode
        rethrow()
    end
end
function interpret_ast_module(interpstate::InterpState, mod, args)
    interpstate.options.debug && @show mod :module args
    expr = Expr(:module, args...)
    eval_ast(interpstate, mod, expr)
end

function interpret_ast_expr(interpstate::InterpState, mod, expr::Expr)
    if expr.head == :comparison
        interpret_ast_comparison(interpstate, mod, expr.args)
    elseif expr.head == :(||)
        interpret_ast_or(interpstate, mod, expr.args)
    elseif expr.head == :(&&)
        interpret_ast_and(interpstate, mod, expr.args)
    elseif expr.head == :primitive
        interpret_ast_primitive(interpstate, mod, expr.args)
    elseif expr.head == :call
        interpret_ast_call(interpstate, mod, expr.args)
    elseif expr.head == :macrocall
        interpret_ast_macrocall(interpstate, mod, expr.args)
    elseif expr.head == :(.=)
        interpret_ast_broadcast(interpstate, mod, expr.args)
    elseif expr.head == :(=)
        interpret_ast_assign(interpstate, mod, expr.args)
    elseif expr.head == :const
        interpret_ast_const(interpstate, mod, expr.args)
    elseif expr.head == :local
        interpret_ast_local(interpstate, mod, expr.args)
    elseif expr.head == :global
        interpret_ast_global(interpstate, mod, expr.args)
    elseif expr.head == :let
        interpret_ast_let(interpstate, mod, expr.args)
    elseif expr.head == :block
        interpret_ast_block(interpstate, mod, expr.args)
    elseif expr.head == :try
        interpret_ast_try(interpstate, mod, expr.args)
    elseif expr.head == :do
        interpret_ast_do(interpstate, mod, expr.args)
    elseif expr.head == :if
        interpret_ast_if(interpstate, mod, expr.args)
    elseif expr.head == :for
        interpret_ast_for(interpstate, mod, expr.args)
    elseif expr.head == :while
        interpret_ast_while(interpstate, mod, expr.args)
    elseif expr.head == :function
        interpret_ast_function(interpstate, mod, expr.args)
    elseif expr.head == :where
        interpret_ast_where(interpstate, mod, expr.args)
    elseif expr.head == :macro
        interpret_ast_macro(interpstate, mod, expr.args)
    elseif expr.head == :struct
        interpret_ast_struct(interpstate, mod, expr.args)
    elseif expr.head == :curly
        interpret_ast_curly(interpstate, mod, expr.args)
    elseif expr.head == :abstract
        interpret_ast_abstract(interpstate, mod, expr.args)
    elseif expr.head == :using
        interpret_ast_using(interpstate, mod, expr.args)
    elseif expr.head == :import
        interpret_ast_import(interpstate, mod, expr.args)
    elseif expr.head == :export
        interpret_ast_export(interpstate, mod, expr.args)
    elseif expr.head == :error
        interpret_ast_error(interpstate, mod, expr.args)
    elseif expr.head == :incomplete
        interpret_ast_incomplete(interpstate, mod, expr.args)
    elseif expr.head == :toplevel
        interpret_ast_toplevel(interpstate, mod, expr.args)
    elseif expr.head == :module
        interpret_ast_module(interpstate, mod, expr.args)
    else
        @show expr
        @assert false
    end
end

function interpret_ast_node(interpstate::InterpState, mod, node)
    @nospecialize node
    if node isa Expr
        expr = node
        interpret_ast_expr(interpstate, mod, expr)
    elseif node isa Symbol
        symbol = node
        eval_ast(interpstate, mod, symbol)
    elseif node isa LineNumberNode
        linenumbernode = node
        linenumbernode
    else
        @show typeof(node) node
        @assert false
    end
end

function interpret_ast(mod, expr, options)
    interpstate = interp_state(mod, options)
    interpret_ast_node(interpstate, mod, expr)
end
