# Tools

Utility scripts used by the dotfiles setup or run independently.

| Script | Description | Used by |
|--------|-------------|---------|
| `setup.sh` | Main bootstrap script — symlinks configs, installs tools (fzf, bat, ripgrep, lazygit), copies Neovim and lazygit configs, sets git aliases | Run manually on a new system |
| `bt-connect.sh` | Connect/disconnect Bluetooth devices by name | `btcon` alias in `.bash_aliases` |
| `weather.sh` | Fetches current weather for a city via the Open-Meteo API (5-min cache) | tmux status bar |
| `tmux-bluetooth.sh` | Prints Bluetooth connection status icon | tmux status bar |
| `tmux-vpn.sh` | Prints active VPN/WireGuard connection name or "off" | tmux status bar |
| `check-connection.sh` | Prints connection type icon — ethernet (󰈀), wifi (󰖩), or offline (󰖪) | tmux status bar |
| `update-neovim.sh` | Downloads and installs the latest Neovim AppImage | Run manually |
| `update-lazygit.sh` | Downloads and installs the latest Lazygit release | Run manually |
| `update-kitty.sh` | Checks for the latest stable kitty release, shows changelog, and installs if confirmed | Run manually |
| `update-tmux.sh` | Checks for the latest tmux release, shows changelog, builds from source, and installs if confirmed | Run manually |
| `setup-macos.sh` | macOS bootstrap — installs Homebrew packages, symlinks configs, patches paths for macOS | Run manually on a new Mac |
| `copilot-install.sh` | Installs the GitHub Copilot CLI `.deb` package (amd64/arm64) | Run manually |
| `maybe-tokyo-night-theme.sh` | Applies the Tokyo Night color scheme to GNOME Terminal | Run manually |
| `map-this-dir.sh` | Generates and fixes `compile_commands.json` for a Bazel target (for clangd/LSP) | Run manually |
| `dap-debug.sh` | CLI wrapper for GDB in DAP interpreter mode for agent-based debugging | Run manually by agents |
