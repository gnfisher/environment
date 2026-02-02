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
    
    # Tango Sky Blue - classic GNOME/Emacs feel
    set_color --bold 729fcf
    echo -n $path
    set_color 888a85
    echo -n (__git_prompt)
    set_color --bold 729fcf
    echo -n '$ '
    set_color normal
end
