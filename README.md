# dotfiles for UNIX systems

Configuration files for tmux, vim, etc

## Files:
- `setup.sh`: file to execute when using, for example, a new system where one would like to have its personal configurations in the applications. Creates links for files that are present in this directory

- `.tmux.conf`: Configuration file for [TMUX](https://github.com/tmux/tmux)
	- Changes the key-bind prefix from C-b to C-s
	- Makes the active pane border green
	- Possible to move between windows with Shift+arrow keys
    - Status bar is on top
    - Status bar colours are configured to be "sortof black" in background, plus other things
    - Status bar shows:
        - Operative System and kernel version
        - Battery condition (requires `acpi` to be installed)
        - Date and time
    - **NOTE**: currently this file must be sourced every time tmux is opened:
        - `<key-bind> : source-file ~/.tmux.conf` or
        - `tmux source-file ~/.tmux.conf`
        - `tmuxconf` alias (this must be configured in `.aliases` file)
    - It's possible to navigate between panes using IJKL keys:
        - Up: `<key-bind> i`
        - Down:`<key-bind> k`
        - Left:`<key-bind> j`
        - Right:`<key-bind> l`
    - [Tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) is active
        - `<key-bind> Ctrl-s` to save a session
        - `<key-bind> Ctrl-r` to restore a session
        - Saves and restores Vim sessions
        - Saves and restores shell history
        - Saves session continuously [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)

- `.vimrc`: Configuration for the command line text editor [VIM](https://www.vim.org)
    - 4 space tabs
    - New lines are auto-indented
    - Curly-braces(`{}`) will be aligned automatically
    - In the statusbar are showed:
        - File path and name
        - Cursor current line and column
    - Lines are showed
    - Colorscheme `slate` is set

## Extra instructions

### Run `tmux` at terminal start

Add the following command to your `~/.bashrc` file:
```bash
# Run tmux when starting a new terminal
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
```

### Add an alias for loading tmux configuration

Add the following command to your ~/.bashrc file:
```bash
# Run `tmuxconf` to load tmux configuration
alias tmuxconf='tmux source-file ~/.tmux.conf'
```

Then, source the file:
```bash
$> source ~/.bashrc
```

### Copy+Paste in `tmux` ([more info](https://awhan.wordpress.com/2010/06/20/copy-paste-in-tmux/)):

- enter copy mode using `<key-bind> [`
- navigate to beginning of text, you want to select and hit `Ctrl+space`
- move around using arrow keys to select region
- when you reach end of region simply hit `Alt+w` to copy the region
- now `<key-bind> ]` will paste the selection

### Pop /un-pop a specific pane in tmux:
`<key-bind> z`
