# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

```bash
make setup          # Full setup: symlink configs + install tools (fzf, bat, ripgrep, lazygit)
make link           # Symlink configs to $HOME (nvim, fish, kitty, lazygit, tmux, bash_aliases)
make update         # Update all tools (neovim, lazygit, kitty, tmux)
make verify         # Check all symlinks are correctly in place
make clean          # Remove backup files
```

Test a tmux status script directly:
```bash
/home/s0001483/dotfiles/tmux/tmux-vpn.sh
tmux source-file ~/.tmux.conf   # Reload tmux config
```

## Architecture

This is a dotfiles repo. Configs live here and are symlinked into `$HOME` / `$HOME/.config/` by `make link`. Key layout:

- `nvim/` → `~/.config/nvim` — Neovim config, plugin-managed by `lazy.nvim`. All plugins are declared in `nvim/lua/plugins/`.
- `fish/` → `~/.config/fish` — Fish shell config. Aliases in `fish_aliases.fish`; custom functions in `fish/functions/`.
- `tmux/.tmux.conf` (root) → `~/.tmux.conf` — Tmux config with prefix `Ctrl-s`.
- `kitty/` → `~/.config/kitty`
- `lazygit/` → `~/.config/lazygit`
- `.bash_aliases` (root) → `~/.bash_aliases` — Bash aliases; machine-local settings belong in `~/.bash_local`.
- `extra-bash/` — Sourced by `.bashrc` via `tools/setup.sh`; Git-aware prompt and Vi-mode.
- `tools/` — Bootstrap scripts: `setup.sh` installs CLI tools and sets git aliases; `bt-connect.sh` (Bluetooth), `dap-debug.sh` (C++ DAP wrapper).
- `update-scripts/` — One script per tool; called by `make update`. Each fetches the latest release and installs it.

## Tmux Status Bar Scripts (`tmux/tmux-*.sh`)

These four scripts (`tmux-bluetooth.sh`, `tmux-check-connection.sh`, `tmux-vpn.sh`, `tmux-weather.sh`) are invoked by tmux on every status bar refresh (~30 s). They **must**:
- Exit fast — no blocking waits.
- Never exit non-zero — use `|| true` or `2>/dev/null` when commands may fail (e.g., `nmcli` with no active VPN, `grep` with no match).
- Handle missing external services silently.

Dependencies: `nmcli` (VPN/Bluetooth), `curl` (weather via Open-Meteo).

## Customization Points

- **Weather city**: `@city` tmux variable, set on line 60 of `.tmux.conf` (default: `Gothenburg`).
- **Machine-local env vars**: add to `~/.bash_local` (sourced by `extra-bash`) — do not commit machine-specific settings.
