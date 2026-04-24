# Themes

A centralized colour palette system. One theme file drives the colours for all four tools — kitty, tmux, neovim, and fish — so changing a theme updates everything at once.

## How it works

```
themes/<theme>.sh          ← single source of truth (edit this)
       │
       └─ apply-theme.sh  ← reads the palette, writes three output files:
               │
               ├─ generated/kitty-colors.conf   → included by kitty/kitty.conf
               ├─ generated/tmux-colors.conf    → sourced by .tmux.conf
               └─ nvim/lua/palette.lua          → required by nvim plugins
```

**Fish** requires no generated file — it inherits colours automatically from kitty's ANSI palette (`color0`–`color15`) at render time. The comments in each theme file document which slot maps to which fish named colour (e.g. `brblue`, `bryellow`).

The generated files are committed to the repo so the theme works on a fresh clone without running any script first.

## Applying a theme

```bash
make theme                  # apply the default theme (flexoki)
make theme THEME=flexoki    # explicit
make theme THEME=opencode   # switch to the opencode palette
```

After running, reload each tool:

| Tool   | Reload command                  |
| :----- | :------------------------------ |
| kitty  | `ctrl+shift+F5`                 |
| tmux   | `tmux source ~/.tmux.conf`      |
| neovim | restart nvim                    |
| fish   | opens automatically via kitty   |

## Creating a new theme

1. Copy an existing theme file as a starting point:
   ```bash
   cp themes/flexoki.sh themes/mytheme.sh
   ```
2. Edit the hex values in `themes/mytheme.sh`. All values are written **without** a leading `#` — the generator adds it.
3. Apply it:
   ```bash
   make theme THEME=mytheme
   ```

## Available themes

| File          | Description                                              |
| :------------ | :------------------------------------------------------- |
| `flexoki.sh`  | Flexoki Dark by Steph Ango — warm blacks with orange and blue accents |
| `opencode.sh` | Original opencode.ai palette — muted blue-gray scheme    |

## Variable reference

Every theme file must define the following variables. Grouped by consumer:

### Shared backgrounds / foregrounds
| Variable          | Used by              | Purpose                          |
| :---------------- | :------------------- | :------------------------------- |
| `THM_BG`          | tmux, kitty (`color0`) | Primary background               |
| `THM_BG_DARK`     | nvim                 | Darker background (sidebars, statusline) |
| `THM_BG_HIGHLIGHT`| nvim                 | Hover / cursorline highlight     |
| `THM_BG_POPUP`    | nvim                 | Popup / float background         |
| `THM_BG_SEARCH`   | nvim                 | Search match background          |
| `THM_BG_VISUAL`   | nvim                 | Visual selection background      |
| `THM_SURFACE_0`   | tmux, nvim           | Raised surface (e.g. lualine b)  |
| `THM_OVERLAY_0`   | tmux, kitty (`color8`) | Muted overlay / separators      |
| `THM_FG`          | tmux, kitty (`color7`) | Primary foreground               |
| `THM_FG_DARK`     | nvim, kitty (`color15`) | Dimmed foreground               |
| `THM_FG_GUTTER`   | nvim                 | Line numbers, inactive text      |
| `THM_DARK3`       | nvim                 | Dark neutral tone                |
| `THM_DARK5`       | nvim                 | Mid neutral tone                 |

### Accent colours
| Variable    | Used by                        | Purpose                     |
| :---------- | :----------------------------- | :-------------------------- |
| `THM_BLUE`  | tmux (`@thm_blue`), nvim, kitty (`color4`) | Primary blue accent |
| `THM_BLUE1`–`THM_BLUE7` | nvim            | Blue family variants        |
| `THM_RED`   | nvim, kitty (`color1`, `color9`) | Errors, diagnostics       |
| `THM_RED1`  | nvim                           | Darker red variant          |
| `THM_GREEN` | nvim, kitty (`color2`, `color10`) | Success, added diffs      |
| `THM_CYAN`  | nvim, kitty (`color6`, `color14`) | Strings, params           |
| `THM_YELLOW`| nvim, kitty (`color3`, `color11`) | Warnings                  |
| `THM_ORANGE`| nvim, tmux (`@thm_peach`)      | Warm accent                 |
| `THM_PURPLE`| nvim, kitty (`color5`, `color13`) | Keywords, types           |
| `THM_MAGENTA`| nvim, kitty                   | Special syntax              |
| `THM_COMMENT`| nvim                          | Comment text colour         |

### tmux status bar
| Variable             | tmux variable    | Appears on                          |
| :------------------- | :--------------- | :---------------------------------- |
| `THM_TMUX_RED`       | `@thm_red`       | Prefix-active highlight (status left) |
| `THM_TMUX_GREEN`     | `@thm_green`     | Session name (normal state)         |
| `THM_TMUX_YELLOW`    | `@thm_yellow`    | Zoom indicator                      |
| `THM_TMUX_MAROON`    | `@thm_maroon`    | Current pane command                |
| `THM_TMUX_ROSEWATER` | `@thm_rosewater` | Secondary neutral                   |
| `THM_MUSIC`          | `@thm_music`     | playerctl widget                    |
| `THM_SEPARATOR`      | `@thm_separator` | `\|` dividers                       |
| `THM_WEATHER`        | `@thm_weather`   | Weather + connection widgets        |
| `THM_BLUETOOTH`      | `@thm_bluetooth` | Bluetooth widget                    |
| `THM_VPN`            | `@thm_vpn`       | VPN widget                          |
| `THM_TIME`           | `@thm_time`      | Date / time                         |
| `THM_BATTERY_OK`     | `@thm_battery_ok`| Battery (normal)                    |
| `THM_BATTERY_LOW`    | `@thm_battery_low`| Battery (≤10%)                     |

### kitty terminal palette
| Variable         | ANSI slot | fish named colour                        |
| :--------------- | :-------- | :--------------------------------------- |
| `KITTY_COLOR0`   | 0         | `black`                                  |
| `KITTY_COLOR1`   | 1         | `red` — errors, comments                 |
| `KITTY_COLOR2`   | 2         | `green` — cwd, `end`                     |
| `KITTY_COLOR3`   | 3         | `yellow` — quotes, remote host           |
| `KITTY_COLOR4`   | 4         | `blue` — commands                        |
| `KITTY_COLOR5`   | 5         | `magenta`                                |
| `KITTY_COLOR6`   | 6         | `cyan` — params, redirections            |
| `KITTY_COLOR7`   | 7         | `white`                                  |
| `KITTY_COLOR8`   | 8         | `brblack` — autosuggestions              |
| `KITTY_COLOR9`   | 9         | `brred`                                  |
| `KITTY_COLOR10`  | 10        | `brgreen` — username in prompt           |
| `KITTY_COLOR11`  | 11        | `bryellow` — cwd in prompt               |
| `KITTY_COLOR12`  | 12        | `brblue` — user@host in prompt           |
| `KITTY_COLOR13`  | 13        | `brmagenta` — git branch in prompt       |
| `KITTY_COLOR14`  | 14        | `brcyan` — escape sequences, operators   |
| `KITTY_COLOR15`  | 15        | `brwhite`                                |
| `KITTY_CURSOR`   | —         | Cursor colour                            |
| `KITTY_CURSOR_TEXT` | —      | Text colour under cursor                 |
| `KITTY_SELECTION_FG` / `_BG` | — | Selection colours                   |
| `KITTY_URL`      | —         | URL underline colour                     |
| `KITTY_ACTIVE_TAB_FG` / `_BG` | — | Active tab colours                 |
| `KITTY_INACTIVE_TAB_FG` / `_BG` | — | Inactive tab colours             |

### neovim
| Variable              | Used in lualine as            |
| :-------------------- | :---------------------------- |
| `NVIM_BG`             | Main editor background        |
| `NVIM_MODE_NORMAL`    | Normal mode — section `a` bg  |
| `NVIM_MODE_INSERT`    | Insert mode — section `a` bg  |
| `NVIM_MODE_VISUAL`    | Visual mode — section `a` bg  |
| `NVIM_MODE_REPLACE`   | Replace mode — section `a` bg |
| `NVIM_MODE_COMMAND`   | Command mode — section `a` bg |
| `NVIM_MODE_COMMAND_FG`| Command mode — section `a` fg |
