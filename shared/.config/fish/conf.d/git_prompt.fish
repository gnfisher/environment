# Use fish_git_prompt for optimized git status
status is-interactive; or return
set -g __fish_git_prompt_show_informative_status 0
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 0
set -g __fish_git_prompt_showcolorhints 1
function __is_light_theme
    set -l theme_file "$HOME/.local/state/theme-mode"
    test -f "$theme_file"; and test (cat "$theme_file") = "light"
end

if __is_light_theme
    set -g __fish_git_prompt_color_branch brblack
    set -g __fish_git_prompt_color_branch_dirty brred
else
    set -g __fish_git_prompt_color_branch bryellow
    set -g __fish_git_prompt_color_branch_dirty brred
end
