# Lazy-load fzf bindings on first fzf invocation
status is-interactive; or return
if test -f ~/.config/fish/functions/fzf_key_bindings.fish
    set -g __fzf_lazy_loaded 0
    function __fzf_lazy_load
        if test $__fzf_lazy_loaded -eq 1
            return
        end
        set -g __fzf_lazy_loaded 1
        source ~/.config/fish/functions/fzf_key_bindings.fish
    end
    function fzf
        __fzf_lazy_load
        command fzf $argv
    end
    function fzf-tmux
        __fzf_lazy_load
        command fzf-tmux $argv
    end
end
