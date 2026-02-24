# Dotfiles

Personal configuration files and utility scripts for Linux (Ubuntu/GNOME).

## Quick Start

```bash
git clone ~/dotfiles
cd ~/dotfiles
chmod +x tools/setup.sh
./tools/setup.sh
```

`setup.sh` will symlink configs, install tools (fzf, bat, ripgrep, lazygit), copy the Neovim and lazygit configs, set git aliases, and append extra shell settings to `~/.bashrc`.

## Repository Structure

```
dotfiles/
├── .bash_aliases        # Shell aliases (loaded via ~/.bash_aliases symlink)
├── .tmux.conf           # tmux config (Catppuccin Macchiato theme)
├── extra-bash           # Extra .bashrc content (prompt, vi mode, tmux auto-start)
├── coffee.txt           # ASCII art for the coffee alias
├── nvim/                # Neovim config (Lua, lazy.nvim)
├── fish/                # Fish shell config (vi mode, aliases, prompt)
│   ├── config.fish
│   ├── fish_aliases.fish
│   └── functions/
│       ├── fish_mode_prompt.fish
│       └── fish_prompt.fish
├── kitty/               # Kitty terminal config (Tokyo Night theme)
│   └── kitty.conf
├── lazygit/             # lazygit custom config (Gerrit push keybind)
└── tools/               # Utility scripts (see tools/README.md)
    ├── setup.sh
    ├── bt-connect.sh
    ├── weather.sh
    ├── tmux-bluetooth.sh
    ├── tmux-vpn.sh
    ├── update-neovim.sh
    ├── update-kitty.sh
    ├── copilot-install.sh
    ├── maybe-tokyo-night-theme.sh
    └── map-this-dir.sh
```

## Configuration

### `.tmux.conf`

[tmux](https://github.com/tmux/tmux) with the [Catppuccin](https://github.com/catppuccin/tmux) Macchiato theme.

- Prefix: `C-s` — Vi-style pane navigation (`h`/`j`/`k`/`l`)
- `v` / `b` to split vertically / horizontally
- `C-h` / `C-l` to switch windows, number keys to resize panes
- Status bar (top): session, command, path, now-playing, weather, Bluetooth, battery, online status, date & time
- Plugins: TPM, resurrect, continuum (auto-restore), online-status, battery, nerd-font-window-name

### `.bash_aliases`

| Alias | Description |
|-------|-------------|
| `ff` | Open files via fzf + bat preview in Neovim |
| `vpnup` / `vpndown` | Connect / disconnect VPN |
| `ll`, `la`, `l` | Common `ls` shortcuts |
| `vim` | Redirects to `nvim` |
| `gti` | Typo-proof `git` |
| `coffee` | ☕ ASCII art |
| `hackerman` | Hollywood hacker mode (Docker) |
| `auto-update` | `apt update && upgrade -y` |
| `btcon` | Bluetooth connect (runs `tools/bt-connect.sh`) |
| `bambu` | Launch Bambu Studio |

### `extra-bash`

Appended to `~/.bashrc` by `setup.sh`:
- Auto-start tmux on terminal open
- Git branch in prompt
- Vi mode with mode indicator
- Caps Lock → Escape remap

### `nvim/`

[Neovim](https://neovim.io/) configuration (Lua, managed with [lazy.nvim](https://github.com/folke/lazy.nvim)). Copied to `~/.config/nvim` by `setup.sh`.

### `lazygit/`

Custom [lazygit](https://github.com/jesseduffield/lazygit) config — adds `Ctrl+P` to push to `refs/for/master` (Gerrit workflow). Copied to `~/.config/lazygit/` by `setup.sh`.

### `fish/`

[Fish shell](https://fishshell.com/) configuration. Includes auto-start tmux, vi key bindings, fzf integration, Caps Lock → Escape remap, and shell aliases mirroring `.bash_aliases`. Custom prompt with git branch and vi mode indicator.

### `kitty/`

[Kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator configuration with the Tokyo Night color scheme, fish as the default shell, and minimal window chrome.

## Tools

See [`tools/README.md`](tools/README.md) for details on each utility script.

