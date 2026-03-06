# Vi-mode indicator shown at the start of each prompt line.
# Fish calls this function automatically when fish_vi_key_bindings is active.
# Displays the current editing mode as a colored tag:
#   [CMD] red     — normal/command mode  (Esc)
#   [INS] green   — insert mode          (i, a, o, …)
#   [REP] yellow  — single-char replace  (r)
#   [VIS] magenta — visual selection      (v)
function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo '[CMD]'
        case insert
            set_color --bold green
            echo '[INS]'
        case replace_one
            set_color --bold yellow
            echo '[REP]'
        case visual
            set_color --bold magenta
            echo '[VIS]'
    end
    set_color normal
    echo -n ' '
end
