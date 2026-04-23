# Update Scripts

Automated update scripts for installing the latest versions of tools. Run via `make update`.

| Script | Description |
| :--- | :--- |
| `update-neovim.sh` | Downloads and installs the latest Neovim AppImage; supports `x86_64` and `arm64` |
| `update-lazygit.sh` | Downloads and installs the latest Lazygit release; supports `x86_64` and `arm64` |
| `update-kitty.sh` | Checks for the latest stable kitty release, shows changelog, and installs if confirmed |
| `update-tmux.sh` | Checks for the latest tmux release, shows changelog, builds from source, and installs if confirmed |

Both `update-neovim.sh` and `update-lazygit.sh` auto-detect the host architecture via `uname -m`. Neovim supports `x86_64` and `aarch64` (arm64) via AppImage. Lazygit additionally supports `armv7l`.

## Usage

```bash
make update                  # Update all tools
./update-scripts/update-neovim.sh  # Update just Neovim
```