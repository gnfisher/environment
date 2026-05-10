# Aliases
status is-interactive; or return
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias rg='rg --hidden'
alias grep='grep --color=auto'

# Helpful
alias dots='cd ~/Development/gnfisher/environment/'
alias dev='cd ~/Development'
alias copilot='copilot --yolo'

# Workspaces
alias wl='ws list'
alias wla='ws list --all'
alias wlf='ws list --full'
alias wo='ws open'
alias wp='ws pick'
alias wn='ws new'
alias wpr='ws pr'

function wop
    if test (count $argv) -eq 0
        echo "Usage: wop <pr-number|pr-name>"
        return 1
    end

    set -l target $argv[1]
    if string match -rq '^[0-9]+$' -- $target
        set target pr-$target
    end

    ws open $target $argv[2..-1]
end

# Repo jumps
alias ghswe='cd ~/Development/github/sweagentd'
alias ghcmc='cd ~/Development/github/copilot-mission-control'
alias ghcar='cd ~/Development/github/copilot-agent-runtime'
alias ghgh='cd ~/Development/github/github'
