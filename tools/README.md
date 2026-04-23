# Tools

Utility scripts used by the dotfiles setup or run independently.

| Script | Description | Used by |
|--------|-------------|---------|
| `setup.sh` | Main bootstrap script — installs tools (fzf, bat, ripgrep, lazygit), sets git aliases, appends `extra-bash` to `.bashrc`; lazygit install auto-detects arch (`x86_64` / `arm64`) and installs to `~/.local/bin` | `make install-tools` |
| `bt-connect.sh` | Connect/disconnect Bluetooth devices by name | `btcon` alias in `.bash_aliases` |
| `setup-macos.sh` | macOS bootstrap — installs Homebrew packages, symlinks configs, patches paths for macOS | Run manually on a new Mac |
| `copilot-install.sh` | Installs the GitHub Copilot CLI `.deb` package (amd64/arm64) | Run manually |
| `maybe-tokyo-night-theme.sh` | Applies the Tokyo Night color scheme to GNOME Terminal | Run manually |
| `map-this-dir.sh` | Generates and fixes `compile_commands.json` for a Bazel target (for clangd/LSP) | Run manually |
| `dap-debug.sh` | CLI wrapper for GDB in DAP interpreter mode for agent-based debugging | Run manually by agents |
