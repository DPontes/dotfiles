# Required so that fzf shows hidden files
export FZF_DEFAULT_COMMAND='find .'

# opens the chosen file from fzf using coloured bat
alias ff='nvim $(fzf -m --preview "bat --color=always --style=numbers --line-range=:500 {}")'

# VPN alias
alias vpnup='nmcli con up Zenseact-SE --ask'
alias vpndown='nmcli con down Zenseact-SE'

# Open Bambu Sutdio
alias bambu='~/Downloads/Bambu_Studio_ubuntu-v01.09.07.52-20.04.AppImage'

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Avoid misspelling Git
alias gti='git'

# Neovim is better than vim
alias vim='nvim'

# Coffee Time
alias coffee="reset; cat ~/dotfiles/coffee.txt"

# Hollywood Hacker
alias hackerman="docker run --rm -it bcbcarl/hollywood"

# Auto Update & Upgrade with automatic "Yes"
alias auto-update="sudo apt update && sudo apt upgrade -y"

# Tool to connect to bluetooth devices via terminal
alias btcon="~/dotfiles/bt-connect.sh"
