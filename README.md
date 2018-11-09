# dotfiles for UNIX systems

Configuration files for tmux, vim, etc

## Files:
- `setup.sh`: file to execute when using, for example, a new system where one would like to have its personal configurations in the applications. Creates links for files that are present in this directory

- `.tmux.conf`: Configuration file for [TMUX](https://github.com/tmux/tmux)
	- Changes the prefix from C-b to C-s
	- Makes the active pane borde green
	- Possible to move between windows with Shift+arrow keys
	- Splits initial window vertically then horizontally
