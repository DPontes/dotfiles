# Tmux Scripts

Scripts that display real-time information in the tmux status bar. Called automatically by `.tmux.conf` on each status bar refresh (every 30s).

| Script | Description | Status Bar |
| :--- | :--- | :--- |
| `tmux-weather.sh` | Fetches weather data with 5-minute cache | Right side |
| `tmux-bluetooth.sh` | Shows Bluetooth connection status (icon) | Right side |
| `tmux-vpn.sh` | Shows active VPN/WireGuard connection name | Right side |
| `tmux-check-connection.sh` | Shows connection type (ethernet/wifi/offline) | Right side |

## Script Safety

These scripts run frequently (every 30s via tmux status bar refresh). They must:
- Be fast
- Handle missing dependencies gracefully
- Never fail hard when external services are unavailable

Always use `|| true` or `2>/dev/null` for commands that may return non-zero.