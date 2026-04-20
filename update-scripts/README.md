# Update Scripts

Automated update scripts for installing the latest versions of tools. Run via `make update`.

| Script | Description |
| :--- | :--- |
| `update-neovim.sh` | Downloads and installs the latest Neovim AppImage |
| `update-lazygit.sh` | Downloads and installs the latest Lazygit release |
| `update-kitty.sh` | Checks for the latest stable kitty release, shows changelog, and installs if confirmed |
| `update-tmux.sh` | Checks for the latest tmux release, shows changelog, builds from source, and installs if confirmed |

## Usage

```bash
make update                  # Update all tools
./update-scripts/update-neovim.sh  # Update just Neovim
```