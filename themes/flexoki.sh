#!/usr/bin/env bash
# themes/flexoki.sh — Flexoki Dark palette by Steph Ango (stephango.com/flexoki)
# Hex values have NO leading '#' — consumers prepend it themselves.

# --- Flexoki source values (for reference) ---
# Backgrounds: black=100f0f, 950=1c1b1a, 900=282726, 850=343331, 800=403e3c
# Neutrals:    700=575653, 600=6f6e69, 500=878580, 300=b7b5ac, 200=cecdc3, 100=e6e4d9
# Accents (_2 variants used for dark-bg visibility):
#   red=d14d41  orange=da702c  yellow=d0a215  green=879a39
#   cyan=3aa99f blue=4385be    purple=8b7ec8  magenta=ce5d97

# Core backgrounds
THM_BG="100f0f"          # flexoki_black — tmux bg, kitty bg, color0
THM_BG_DARK="1c1b1a"     # flexoki_base_950 — nvim bg_dark/sidebar/statusline
THM_BG_HIGHLIGHT="343331" # flexoki_base_850
THM_BG_POPUP="282726"    # flexoki_base_900
THM_BG_SEARCH="205ea6"   # flexoki_blue — search highlight
THM_BG_VISUAL="403e3c"   # flexoki_base_800
THM_SURFACE_0="282726"   # flexoki_base_900
THM_OVERLAY_0="575653"   # flexoki_base_700 — kitty color8 (brblack)

# Foregrounds
THM_FG="cecdc3"          # flexoki_base_200 — primary text, kitty color7, kitty fg
THM_FG_DARK="b7b5ac"     # flexoki_base_300 — kitty color15 (brwhite)
THM_FG_GUTTER="6f6e69"   # flexoki_base_600

# Accents
THM_BLUE="4385be"        # flexoki_blue_2 — primary blue accent
THM_BLUE1="205ea6"       # flexoki_blue
THM_BLUE2="205ea6"       # flexoki_blue
THM_BLUE5="3aa99f"       # flexoki_cyan_2
THM_BLUE6="3aa99f"       # flexoki_cyan_2
THM_BLUE7="205ea6"       # flexoki_blue
THM_DARK3="6f6e69"       # flexoki_base_600
THM_DARK5="878580"       # flexoki_base_500

# Semantic colors (using _2 variants — brighter, more readable on dark bg)
THM_RED="d14d41"         # flexoki_red_2
THM_RED1="af3029"        # flexoki_red
THM_GREEN="879a39"       # flexoki_green_2
THM_CYAN="3aa99f"        # flexoki_cyan_2
THM_YELLOW="d0a215"      # flexoki_yellow_2
THM_ORANGE="da702c"      # flexoki_orange_2
THM_PURPLE="8b7ec8"      # flexoki_purple_2
THM_MAGENTA="ce5d97"     # flexoki_magenta_2
THM_COMMENT="878580"     # flexoki_base_500

# tmux @thm_* semantic names
THM_TMUX_RED="da702c"    # flexoki_orange_2 — prefix-active highlight (orange as requested)
THM_TMUX_GREEN="879a39"  # flexoki_green_2 — session name (normal)
THM_TMUX_YELLOW="d0a215" # flexoki_yellow_2 — zoom indicator
THM_TMUX_MAROON="b7b5ac" # flexoki_base_300 — current command display
THM_TMUX_ROSEWATER="b7b5ac" # flexoki_base_300

# Status-right widget colors
THM_MUSIC="3aa99f"       # flexoki_cyan_2
THM_SEPARATOR="6f6e69"   # flexoki_base_600
THM_WEATHER="879a39"     # flexoki_green_2
THM_BLUETOOTH="da702c"   # flexoki_orange_2
THM_VPN="da702c"         # flexoki_orange_2
THM_TIME="cecdc3"        # flexoki_base_200
THM_BATTERY_OK="879a39"  # flexoki_green_2
THM_BATTERY_LOW="d14d41" # flexoki_red_2

# Kitty UI extras
KITTY_CURSOR="da702c"        # flexoki_orange_2 — warm, visible cursor
KITTY_CURSOR_TEXT="100f0f"   # flexoki_black
KITTY_SELECTION_FG="100f0f"  # flexoki_black
KITTY_SELECTION_BG="da702c"  # flexoki_orange_2
KITTY_URL="4385be"           # flexoki_blue_2
KITTY_ACTIVE_TAB_FG="100f0f" # flexoki_black
KITTY_ACTIVE_TAB_BG="da702c" # flexoki_orange_2
KITTY_INACTIVE_TAB_FG="6f6e69" # flexoki_base_600
KITTY_INACTIVE_TAB_BG="282726" # flexoki_base_900

# Kitty color0-15 — fish named colors resolve to these ANSI slots at render time:
# color0=black  color1=red    color2=green  color3=yellow color4=blue
# color5=magenta color6=cyan  color7=white
# color8=brblack color9=brred color10=brgreen color11=bryellow
# color12=brblue color13=brmagenta color14=brcyan color15=brwhite
KITTY_COLOR0="100f0f"    # black      — fish: black
KITTY_COLOR1="d14d41"    # red        — fish: red, comment, error
KITTY_COLOR2="879a39"    # green      — fish: green, cwd, end
KITTY_COLOR3="d0a215"    # yellow     — fish: yellow, quote, host_remote
KITTY_COLOR4="4385be"    # blue       — fish: blue, command
KITTY_COLOR5="8b7ec8"    # magenta    — fish: magenta
KITTY_COLOR6="3aa99f"    # cyan       — fish: cyan, param, redirection
KITTY_COLOR7="cecdc3"    # white      — fish: white
KITTY_COLOR8="575653"    # brblack    — fish: brblack (autosuggestion)
KITTY_COLOR9="d14d41"    # brred      — fish: brred
KITTY_COLOR10="879a39"   # brgreen    — fish: brgreen (user in prompt)
KITTY_COLOR11="d0a215"   # bryellow   — fish: bryellow (cwd in prompt)
KITTY_COLOR12="4385be"   # brblue     — fish: brblue (user@host in prompt)
KITTY_COLOR13="8b7ec8"   # brmagenta  — fish: brmagenta (git branch in prompt)
KITTY_COLOR14="3aa99f"   # brcyan     — fish: brcyan (escape, operator)
KITTY_COLOR15="e6e4d9"   # brwhite    — fish: brwhite

# Neovim base bg (slightly lighter than tmux bg for editor depth)
NVIM_BG="1c1b1a"         # flexoki_base_950

# Lualine mode accent colors (used as 'a' section background per vim mode)
NVIM_MODE_NORMAL="4385be"    # flexoki_blue_2
NVIM_MODE_INSERT="879a39"    # flexoki_green_2
NVIM_MODE_VISUAL="8b7ec8"    # flexoki_purple_2
NVIM_MODE_REPLACE="d14d41"   # flexoki_red_2
NVIM_MODE_COMMAND="da702c"   # flexoki_orange_2
NVIM_MODE_COMMAND_FG="100f0f" # flexoki_black
