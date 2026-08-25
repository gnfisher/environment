if test -d /opt/homebrew
    set -gx HOMEBREW_PREFIX /opt/homebrew
else if test -x /usr/local/bin/brew
    set -gx HOMEBREW_PREFIX /usr/local
end

if set -q HOMEBREW_PREFIX
    set -gx SHELL $HOMEBREW_PREFIX/bin/fish
    fish_add_path --global --prepend $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
end

if test -d $HOME/.local/bin
    fish_add_path --global --prepend $HOME/.local/bin
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GOPATH $HOME/go
set -gx GOPROXY https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct
set -gx GOPRIVATE ""
set -gx GONOPROXY ""
set -gx GONOSUMDB "github.com/github/*"
set -gx OPENCODE_DISABLE_CLAUDE_CODE_SKILLS 1

if test -d $GOPATH/bin
    fish_add_path --global --prepend $GOPATH/bin
end

for private_config in \
        $HOME/.config/environment/private.fish \
        $HOME/.config/environment/splunk-token.fish
    if test -r $private_config
        source $private_config
    end
end

if not status is-interactive
    return
end

if isatty stdin
    set -gx GPG_TTY (tty)
end
set -g fish_greeting
fish_default_key_bindings

set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showuntrackedfiles yes
set -g __fish_git_prompt_color_branch yellow
set -g __fish_git_prompt_color_dirtystate red
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_char_dirtystate '*'
set -g __fish_git_prompt_char_untrackedfiles '?'

alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'
alias .. 'cd ..'
alias ... 'cd ../..'
alias g git
alias rg 'rg --hidden'
alias copilot 'copilot --yolo'
alias dots 'cd ~/Development/gnfisher/environment'
alias dev 'cd ~/Development'
alias ghswe 'cd ~/Development/github/sweagentd'
alias ghcmc 'cd ~/Development/github/copilot-mission-control'
alias ghcar 'cd ~/Development/github/copilot-agent-runtime'
alias ghgh 'cd ~/Development/github/github'

if type -q mise
    mise activate fish | source
end

if set -q HOMEBREW_PREFIX
    set -l fzf_bindings $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.fish
    if test -r $fzf_bindings
        source $fzf_bindings
    end
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
