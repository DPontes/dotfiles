#!/usr/bin/env bash
# themes/opencode.sh — single source of truth for all color values
# Hex values have NO leading '#' — consumers prepend it themselves.

# Core backgrounds
THM_BG="211E1E"          # tmux bg, kitty bg, kitty color0
THM_BG_DARK="1E1A19"     # nvim bg_dark/sidebar/statusline
THM_BG_HIGHLIGHT="3A3230"
THM_BG_POPUP="332C2B"
THM_BG_SEARCH="4A6B8A"
THM_BG_VISUAL="3D3635"
THM_SURFACE_0="2E2928"
THM_OVERLAY_0="4B4646"   # kitty color8 (brblack)

# Foregrounds
THM_FG="F1ECEC"          # kitty color7, kitty fg
THM_FG_DARK="C4BFBF"     # kitty color15 (brwhite)
THM_FG_GUTTER="6A6464"

# Accents (blue-gray family)
THM_BLUE="8AADCA"        # primary accent — kitty color4, color10, color12
THM_BLUE1="7A9AB5"
THM_BLUE2="6A8AA5"
THM_BLUE5="9AAFC0"       # kitty color5, color6, color13, color14
THM_BLUE6="B0C4D4"
THM_BLUE7="5C7A9A"
THM_DARK3="6A6464"
THM_DARK5="8E8888"

# Semantic colors
THM_RED="e06c75"         # kitty color1, color9
THM_RED1="C96060"
THM_GREEN="8AADCA"       # kitty color2, color10 (muted blue used as green in this palette)
THM_CYAN="9AAFC0"        # kitty color6, color14
THM_YELLOW="A09080"      # kitty color3, color11
THM_ORANGE="8B7050"
THM_PURPLE="7A8FA0"
THM_MAGENTA="9AAFC0"     # kitty color5, color13
THM_COMMENT="6A6464"

# tmux @thm_* semantic names (preserves existing naming)
THM_TMUX_RED="fab283"    # orange — used as prefix-active highlight on the status bar
THM_TMUX_GREEN="C4BFBF"
THM_TMUX_YELLOW="8E8888"
THM_TMUX_MAROON="C4BFBF"
THM_TMUX_ROSEWATER="B7B1B1"

# Status-right widget colors — original Palette A accent colours preserved from before centralization
THM_MUSIC="56b6c2"
THM_SEPARATOR="6a6a6a"
THM_WEATHER="7fd88f"
THM_BLUETOOTH="fab283"
THM_VPN="fab283"
THM_TIME="e0e0e0"
THM_BATTERY_OK="7fd88f"
THM_BATTERY_LOW="e06c75"

# Kitty UI extras (cursor, selection, tabs)
KITTY_CURSOR="8AADCA"
KITTY_CURSOR_TEXT="211E1E"
KITTY_SELECTION_FG="211E1E"
KITTY_SELECTION_BG="8AADCA"
KITTY_URL="9AAFC0"
KITTY_ACTIVE_TAB_FG="211E1E"
KITTY_ACTIVE_TAB_BG="8AADCA"
KITTY_INACTIVE_TAB_FG="4B4646"
KITTY_INACTIVE_TAB_BG="2E2928"

# Kitty color0-15 — fish named colors resolve to these ANSI slots at render time:
# color0=black  color1=red    color2=green  color3=yellow color4=blue
# color5=magenta color6=cyan  color7=white
# color8=brblack color9=brred color10=brgreen color11=bryellow
# color12=brblue color13=brmagenta color14=brcyan color15=brwhite
KITTY_COLOR0="211E1E"    # black      — fish: black
KITTY_COLOR1="e06c75"    # red        — fish: red, comment, error
KITTY_COLOR2="8AADCA"    # green      — fish: green, cwd, end
KITTY_COLOR3="A09080"    # yellow     — fish: yellow, quote, host_remote
KITTY_COLOR4="8AADCA"    # blue       — fish: blue, command
KITTY_COLOR5="9AAFC0"    # magenta    — fish: magenta
KITTY_COLOR6="9AAFC0"    # cyan       — fish: cyan, param, redirection
KITTY_COLOR7="F1ECEC"    # white      — fish: white
KITTY_COLOR8="4B4646"    # brblack    — fish: brblack (autosuggestion)
KITTY_COLOR9="e06c75"    # brred      — fish: brred
KITTY_COLOR10="8AADCA"   # brgreen    — fish: brgreen (user in prompt)
KITTY_COLOR11="A09080"   # bryellow   — fish: bryellow (cwd in prompt)
KITTY_COLOR12="8AADCA"   # brblue     — fish: brblue (user@host in prompt)
KITTY_COLOR13="9AAFC0"   # brmagenta  — fish: brmagenta (git branch in prompt)
KITTY_COLOR14="9AAFC0"   # brcyan     — fish: brcyan (escape, operator)
KITTY_COLOR15="B0C4D4"   # brwhite    — fish: brwhite

# Neovim base bg is intentionally slightly warmer than tmux bg.
# Set to THM_BG to fully unify, or keep separate for subtle depth.
NVIM_BG="2A2524"

# Lualine mode accent colors (used as the 'a' section background per mode)
NVIM_MODE_NORMAL="4A6B8A"
NVIM_MODE_INSERT="5C7A9A"
NVIM_MODE_VISUAL="7A8FA0"
NVIM_MODE_REPLACE="C96060"
NVIM_MODE_COMMAND="8AADCA"
NVIM_MODE_COMMAND_FG="1E1A19"
