# Prompt: full path + git branch
# Colors adapt to light/dark theme (set by `theme` command)
status is-interactive; or return

function __git_prompt
    set -l git_prompt (fish_git_prompt "%s")
    if test -n "$git_prompt"
        echo -n "[$git_prompt]"
    end
end

function __is_light_theme
    set -l theme_file "$HOME/.local/state/theme-mode"
    test -f "$theme_file"; and test (cat "$theme_file") = "light"
end

function fish_prompt
    set -l path (string replace -r "^$HOME" "~" (pwd))
    
    # Use different colors for light vs dark theme
    if __is_light_theme
        set_color --bold blue
        echo -n $path
        set_color bryellow  # visible on light background
        echo -n (__git_prompt)
        set_color --bold blue
    else
        set_color --bold cyan
        echo -n $path
        set_color brblack
        echo -n (__git_prompt)
        set_color --bold cyan
    end
    
    echo -n '$ '
    set_color normal
end
