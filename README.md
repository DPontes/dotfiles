# Dotfiles

[![OS: Linux](https://img.shields.io/badge/OS-Linux-blue?logo=linux&logoColor=white)](https://www.linux.org/)
[![Shell: Bash/Fish](https://img.shields.io/badge/Shell-Bash%2FFish-green?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Editor: Neovim](https://img.shields.io/badge/Editor-Neovim-90E59A?logo=neovim&logoColor=white)](https://neovim.io/)
[![Multiplexer: tmux](https://img.shields.io/badge/Multiplexer-tmux-blueviolet?logo=tmux&logoColor=white)](https://github.com/tmux/tmux)

A comprehensive, aesthetic, and automated development environment tailored for C++, Python, and general software engineering. Features a swappable colour theme system across Neovim, Tmux, Kitty, and Fish — currently using **Flexoki Dark**.

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

> [!NOTE]
> Supported architectures: `x86_64` and `aarch64` (arm64). Tool installers auto-detect the host arch via `uname -m`.

---

## Makefile

This project uses a Makefile for common tasks:

```bash
make help            # Show available targets
make setup           # Initial setup (symlink + install tools)
make link            # Symlink config files to home; also appends extra-bash to .bashrc
make install-tools   # Install CLI tools (fzf, bat, ripgrep, lazygit)
make update          # Update all tools (neovim, lazygit, kitty, tmux)
make verify          # Verify configs are properly linked
make clean           # Remove backup files
make theme           # Apply the active colour theme (default: flexoki)
make theme THEME=x   # Apply a specific theme (e.g. opencode)
```

> [!NOTE]
> `make link` guards each config directory: it verifies the source exists before removing the destination, preventing accidental data loss. `make install-tools` exits non-zero and prints the error if `setup.sh` fails.

---

## Features

- **Swappable Themes**: Centralized colour palette system — one file drives kitty, tmux, neovim, and fish. Switch themes with `make theme THEME=<name>`.
- **Powerhouse Editor**: Pre-configured Neovim with LSP, Treesitter, Debugging (DAP), and Copilot integration.
- **Robust Multiplexer**: Tmux with a custom status bar showing weather, battery, and system connectivity.
- **Intelligent Shell**: Dual-shell support (Bash/Fish) with Git integration, Vi-mode, and smart aliases.
- **Automated Tooling**: Custom scripts for Bluetooth management, system updates, and DAP-based debugging.

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
2. **Local Settings**: Both `make link` and `setup.sh` append `source $DOTFILES_DIR/extra-bash` to `.bashrc` (idempotent). Use that file or your own `~/.bash_local` for machine-specific environment variables.

---

## Themes (`themes/`)

A centralized colour palette system. Each theme is a single shell file defining all colour variables; `apply-theme.sh` generates tool-specific output files from it.

```bash
make theme                 # Apply active theme (flexoki)
make theme THEME=opencode  # Switch to a different theme
```

After applying, reload each tool: kitty (`ctrl+shift+F5`), tmux (`tmux source ~/.tmux.conf`), nvim (restart).

| File          | Description                                                      |
| :------------ | :--------------------------------------------------------------- |
| `flexoki.sh`  | Flexoki Dark — warm blacks with orange and blue accents (active) |
| `opencode.sh` | Original opencode.ai — muted blue-gray palette                   |

See [`themes/README.md`](themes/README.md) for the full variable reference and instructions for creating new themes.

---

## Utility Tools (`tools/`)

| Script | Purpose |
| :--- | :--- |
| `setup.sh` | Main bootstrap script — installs tools (fzf, bat, ripgrep, lazygit), sets git aliases |
| `bt-connect.sh` | CLI-based Bluetooth device management with connection spinner. |
| `dap-debug.sh` | CLI wrapper for GDB/DAP, enabling agent-based C++ debugging. |

## Update Scripts (`update-scripts/`)

Automated update scripts for installing the latest versions of tools. Run via `make update`.

| Script | Description |
| :--- | :--- |
| `update-neovim.sh` | Downloads and installs the latest Neovim AppImage (`x86_64` / `arm64`) |
| `update-lazygit.sh` | Downloads and installs the latest Lazygit release (`x86_64` / `arm64`) |
| `update-kitty.sh` | Checks for the latest stable kitty release, shows changelog, and installs if confirmed |
| `update-tmux.sh` | Checks for the latest tmux release, shows changelog, builds from source, and installs if confirmed |

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