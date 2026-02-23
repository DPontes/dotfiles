# Auto-start tmux
if status is-interactive; and type -q tmux; and not set -q TMUX
    exec tmux
end

if status is-interactive
    # Vi mode
    fish_vi_key_bindings

    # fzf key bindings (Ctrl+R for history search)
    fzf_key_bindings

    # Remap Caps Lock to Escape
    if type -q setxkbmap
        setxkbmap -option caps:escape
    end

    # Load aliases
    source ~/dotfiles/fish/fish_aliases.fish
end
