# dotfiles for UNIX systems

TODO:
- [ ] Remake the README so it mirrors the current state of the dotfiles

Configuration files for tmux, vim, etc

## Files

### `setup.sh`

File to execute when using, for example, a new system where one would like to have its personal configurations in the applications. Creates links for files that are present in this directory

### `.tmux.conf`

Configuration file for [TMUX](https://github.com/tmux/tmux)

- Changes the key-bind prefix from C-b to C-s
- Possible to move between windows with Shift+arrow keys
- Status bar is on top
- Status bar colours are configured to be "sortof black" in background, plus other things
- Status bar shows:
  - Operative System and kernel version
  - Date and time

### `.vimrc`

Configuration for the command line text editor [VIM](https://www.vim.org)

([raw .vimrc file](https://raw.githubusercontent.com/DPontes/dotfiles/master/.vimrc))

- 4 space tabs
- New lines are auto-indented
- Curly-braces (`{}`) will be aligned automatically
- In the statusbar are showed:
  - File path and name
  - Cursor current line and column
- Lines are showed
- Colorscheme `slate` is set
- Search hits are highlighted
- Shows whitespaces and tabs with arrows

## Extra instructions

### Run `tmux` at terminal start

Add the following command to your `~/.bashrc` file:

```bash
# Run tmux when starting a new terminal
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
```

### Copy+Paste in `tmux` ([more info](https://awhan.wordpress.com/2010/06/20/copy-paste-in-tmux/))

- enter copy mode using `<key-bind> [`
- navigate to beginning of text, you want to select and hit `Ctrl+space`
- move around using arrow keys to select region
- when you reach end of region simply hit `Alt+w` to copy the region
- now `<key-bind> ]` will paste the selection

### Pop /un-pop a specific pane in tmux

`<key-bind> z`

### Toggle pane synchronization

`<key-bind>` q

## Aliases

Add the following commands to your `~/.bashrc` file:

```bash

# Load tmux configuration
alias tmuxconf='tmux source-file ~/.tmux.conf'


# Change sound profile in BT headset
alias headset-a2dp="pactl set-card-profile $BLUETOOTHHEADSETNAME a2dp_sink"
alias headset-call="pactl set-card-profile $BLUETOOTHHEADSETNAME headset_head_unit"

# Find $BLUETOOTHHEADSETNAME with the "pacmd list-cards" command

# Write the first letters of a command and use Up and Down arrows to go through history for that command
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Git aliases
alias gpm="git push origin master"
alias ga="git add"
alias gaa="git add -A"
alias gs="git status"
alias gc="git commit -m"
alias gd="git diff"
```

Then, source the file:

```bash
$> source ~/.bashrc
```

## Advanced Git Aliases

Visual git history with branches
Add this to your `~/.gitconfig` `alias` section:

```bash
[alias]
  lg = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
  st = status
  d = diff
  pl = pull
  aA = add --all
```

# Show current git branch in command line
```bash
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
```

