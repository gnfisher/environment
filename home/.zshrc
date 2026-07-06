# Minimal interactive zsh setup.
[[ -o interactive ]] || return

typeset -U path fpath

if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
elif [[ -x /usr/local/bin/brew ]]; then
  export HOMEBREW_PREFIX=/usr/local
fi

if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
  fpath=(
    "$HOMEBREW_PREFIX/share/zsh/site-functions"
    "$HOMEBREW_PREFIX/share/zsh-completions"
    $fpath
  )
fi

[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

export EDITOR=nvim
export VISUAL=nvim
# Keep zle in emacs mode even though EDITOR/VISUAL point at nvim.
bindkey -e
export GOPATH="$HOME/go"
export GOPROXY="https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
export GONOPROXY=""
export GONOSUMDB="github.com/github/*"
[[ -d "$GOPATH/bin" ]] && path=("$GOPATH/bin" $path)

export GPG_TTY="${TTY:-$(tty)}"

[[ -r "$HOME/.config/environment/private.zsh" ]] && source "$HOME/.config/environment/private.zsh"
[[ -r "$HOME/.config/environment/splunk-token.zsh" ]] && source "$HOME/.config/environment/splunk-token.zsh"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt auto_cd
setopt interactive_comments
unsetopt beep

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist

autoload -Uz compinit
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
mkdir -p "${_zcompdump:h}"
if [[ -s "$_zcompdump" ]]; then
  compinit -C -d "$_zcompdump"
else
  compinit -u -d "$_zcompdump"
fi
unset _zcompdump

if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ -t 0 ]]; then
    [[ -r "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
    [[ -r "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    [[ -r "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias rg='rg --hidden'
alias copilot='copilot --yolo'
alias dots='cd ~/Development/gnfisher/environment'
alias dev='cd ~/Development'
alias ghswe='cd ~/Development/github/sweagentd'
alias ghcmc='cd ~/Development/github/copilot-mission-control'
alias ghcar='cd ~/Development/github/copilot-agent-runtime'
alias ghgh='cd ~/Development/github/github'

autoload -Uz add-zsh-hook
_set_terminal_title() {
  print -Pn "\e]0;%1~\a"
}
add-zsh-hook precmd _set_terminal_title

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ -t 1 ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if [[ -t 0 && -n "${HOMEBREW_PREFIX:-}" && -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
