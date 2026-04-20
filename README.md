# Dotfiles

[![OS: Linux](https://img.shields.io/badge/OS-Linux-blue?logo=linux&logoColor=white)](https://www.linux.org/)
[![Shell: Bash/Fish](https://img.shields.io/badge/Shell-Bash%2FFish-green?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Editor: Neovim](https://img.shields.io/badge/Editor-Neovim-90E59A?logo=neovim&logoColor=white)](https://neovim.io/)
[![Multiplexer: tmux](https://img.shields.io/badge/Multiplexer-tmux-blueviolet?logo=tmux&logoColor=white)](https://github.com/tmux/tmux)

A comprehensive, aesthetic, and automated development environment tailored for C++, Python, and general software engineering. Features a unified **Opencode.ai color theme** across Neovim, Tmux, Kitty, and Fish.

---

## Quick Start

Get up and running in minutes:

```bash
git clone https://github.com/DPontes/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
make setup
```

> [!NOTE]
> `make setup` runs `make link` (symlinks configs) and `make install-tools` (installs fzf, bat, ripgrep, lazygit). Uses `tools/setup.sh` under the hood.

---

## Makefile

This project uses a Makefile for common tasks:

```bash
make help        # Show available targets
make setup      # Initial setup (symlink + install tools)
make link       # Symlink config files to home
make install-tools # Install CLI tools (fzf, bat, ripgrep, lazygit)
make update     # Update all tools (neovim, lazygit, kitty, tmux)
make verify     # Verify configs are properly linked
make clean      # Remove backup files
```

---

## Features

- **Unified Aesthetics**: Consistent Opencode.ai color theme theme across all tools.
- **Powerhouse Editor**: Pre-configured Neovim with LSP, Treesitter, Debugging (DAP), and Copilot integration.
- **Robust Multiplexer**: Tmux with a custom status bar showing weather, battery, and system connectivity.
- **Intelligent Shell**: Dual-shell support (Bash/Fish) with Git integration, Vi-mode, and smart aliases.
- **Automated Tooling**: Custom scripts for Bluetooth management, system updates, and DAP-based debugging.

---

## Repository Structure

```
dotfiles/
├── Makefile              # Makefile for common tasks
├── nvim/                # Neovim (IDE-like experience with lazy.nvim)
├── .tmux.conf           # Tmux config with status bar enhancements
├── tmux/                # Tmux status bar scripts (tmux-*.sh)
├── fish/                # Fish Shell (modern shell experience)
├── kitty/               # Kitty Terminal (GPU-accelerated terminal)
├── lazygit/             # Lazygit (TUI for Git with Gerrit support)
├── tools/               # Utility Scripts (Automation & system tools)
└── extra-bash           # Bash initialization & environment setup
```

---

## Components Detail

### Editor (Neovim)
Managed by `lazy.nvim`. Key plugins include:
- **LSP**: `mason.nvim` & `nvim-lspconfig` for C++, Python, Lua, and more.
- **DAP**: Debugging support with `codelldb` and a custom CLI `dap-debug.sh`.
- **AI**: GitHub Copilot and CopilotChat integration.
- **UI**: `lualine.nvim`, `neo-tree`, and `telescope.nvim`.

### Shells (Bash & Fish)
- **Bash**: Enhanced with `extra-bash`, featuring a Git-aware prompt and Vi-mode.
- **Fish**: Fully configured with aliases, Vi-mode, and custom functions in `fish/`.
- **Aliases**: Common shortcuts for Git, navigation, and system maintenance in `.bash_aliases`.

### Multiplexer (Tmux)
- **Prefix**: `Ctrl-s` (ergonomic replacement for `Ctrl-b`).
- **Status Bar**: Real-time updates for weather (Open-Meteo), VPN status, and Bluetooth.
- **Navigation**: Vi-style pane switching (`h,j,k,l`).

---

## Customization

To override default settings without polluting the main repository:

1. **Weather City**: The city is stored in `@city` tmux variable (default: `Gothenburg`). Edit `.tmux.conf` line 60 to change it.
2. **Local Settings**: The `setup.sh` script adds `source $DOTFILES_DIR/extra-bash` to `.bashrc`. Use that file or your own `~/.bash_local` for machine-specific environment variables.

---

## Utility Tools (`tools/`)

| Script | Purpose |
| :--- | :--- |
| `bt-connect.sh` | CLI-based Bluetooth device management with connection spinner. |
| `tmux-weather.sh` | Fetches weather data with a 5-minute cache to respect API limits. |
| `dap-debug.sh` | CLI wrapper for GDB/DAP, enabling agent-based C++ debugging. |
| `update-scripts/update-*.sh` | Automated update scripts for Neovim, Lazygit, Kitty, and Tmux. |

## Tmux Scripts (`tmux/tmux-*.sh`)

Scripts that display real-time information in the tmux status bar:

| Script | Description | Status Bar |
| :--- | :--- | :--- |
| `tmux-bluetooth.sh` | Shows Bluetooth connection status (icon) | Right side |
| `tmux-check-connection.sh` | Shows connection type (ethernet/wifi/offline) | Right side |
| `tmux-vpn.sh` | Shows active VPN connection name | Right side |
| `tmux-weather.sh` | Fetches weather data with 5-minute cache | Right side |

These are in `tmux/` and called automatically by tmux via `.tmux.conf`. They run on each status bar refresh.

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for any bugs or feature requests.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## License

Distributed under the MIT License. See `LICENSE` for more information.

---