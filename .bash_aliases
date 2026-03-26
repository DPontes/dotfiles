# .bash_aliases - Custom bash aliases and functions

# Required so that fzf shows hidden files
export FZF_DEFAULT_COMMAND='find .'

# opens the chosen file from fzf using coloured bat
alias ff='nvim $(fzf -m --preview "bat --color=always --style=numbers --line-range=:500 {}")'

# VPN aliases
alias vpnup='nmcli con up Zenseact-SE --ask'
alias vpndown='nmcli con down Zenseact-SE'

# Open Bambu Studio (ensure the path is correct or use a variable)
BAMBU_STUDIO_APPIMAGE="$HOME/Downloads/Bambu_Studio_ubuntu-v01.09.07.52-20.04.AppImage"
alias bambu='[[ -f "$BAMBU_STUDIO_APPIMAGE" ]] && "$BAMBU_STUDIO_APPIMAGE" || echo "Bambu Studio not found at $BAMBU_STUDIO_APPIMAGE"'

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Avoid misspelling Git
alias gti='git'

# Neovim is better than vim
alias vim='nvim'

# Coffee Time
alias coffee="reset; cat $HOME/dotfiles/coffee.txt"

# Hollywood Hacker
alias hackerman="docker run --rm -it bcbcarl/hollywood"

# Auto Update & Upgrade with automatic "Yes"
alias auto-update="sudo apt update && sudo apt upgrade -y"

# Tool to connect to bluetooth devices via terminal
alias btcon="$HOME/dotfiles/tools/bt-connect.sh"
