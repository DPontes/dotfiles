# FZF: show hidden files
set -gx FZF_DEFAULT_COMMAND 'find .'

# Open file from fzf with bat preview in Neovim
function ff
    nvim (fzf -m --preview "bat --color=always --style=numbers --line-range=:500 {}")
end

# VPN
alias vpnup 'nmcli con up Zenseact-SE --ask'
alias vpndown 'nmcli con down Zenseact-SE'

# Bambu Studio
alias bambu '~/Downloads/Bambu_Studio_ubuntu-v01.09.07.52-20.04.AppImage'

# ls shortcuts
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'

# Typo-proof git
alias gti git

# Neovim is better than vim
alias vim nvim

# Coffee Time
function coffee
    reset
    cat ~/dotfiles/coffee.txt
end

# Hollywood Hacker
alias hackerman 'docker run --rm -it bcbcarl/hollywood'

# Auto Update & Upgrade
function auto-update
    sudo apt update && sudo apt upgrade -y
end

# Bluetooth connect
alias btcon '~/dotfiles/tools/bt-connect.sh'
