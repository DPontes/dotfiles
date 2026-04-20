# Dotfiles Agent Instructions

## Setup Commands
- `make setup` - Full setup (symlink configs + install tools)
- `make link` - Symlink configs to `$HOME`
- `make install-tools` - Install fzf, bat, ripgrep, lazygit
- `make verify` - Check symlinks are correct

## Key Paths
- `$HOME/dotfiles/tmux/tmux-*.sh` - Scripts called by tmux status bar (run frequently, keep fast/fail-safe)
- `$HOME/dotfiles/.tmux.conf` - Tmux config (prefix: `Ctrl-s`)
- Tools depend on: `nmcli` (VPN/Bluetooth), `curl` (weather)

## Script Safety
Scripts in `tools/` are invoked by tmux on every status bar refresh or by shell aliases. They must:
- Be fast (status bar scripts run every 30s)
- Handle missing dependencies gracefully
- Never fail hard when external services are unavailable

Example: Always use `|| true` or `2>/dev/null` for commands that may return non-zero (e.g., `nmcli` when no VPN active, `grep` with no match).

## VPN Script (`tmux/tmux-vpn.sh`)
- Uses `nmcli -t -f NAME,TYPE con show --active` to find active VPN/WireGuard
- Must handle empty output (no VPN) gracefully
- Dependencies: `nmcli`, `grep`, `head`, `cut`

## Testing Changes
- Run scripts directly to verify: `/home/s0001483/dotfiles/tmux/tmux-vpn.sh`
- Check tmux loads config: `tmux source-file ~/.tmux.conf`
