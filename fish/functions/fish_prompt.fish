function fish_prompt
    set -l last_status $status

    # user@host
    set_color brblue
    echo -n 'diopon'
    set_color normal
    echo -n '@'
    set_color brblue
    echo -n 'Zen-laptop'
    set_color normal
    echo -n ' '

    # cwd
    set_color bryellow
    echo -n (prompt_pwd)
    set_color normal

    # git branch (inline, after cwd)
    if command -sq git
        set -l branch (git branch --show-current 2>/dev/null)
        if test -n "$branch"
            set -l dirty ''
            if not git diff --quiet 2>/dev/null; or not git diff --cached --quiet 2>/dev/null
                set dirty '*'
            end

            set -l unpushed (git log --oneline @{upstream}.. 2>/dev/null | count)

            set_color normal
            echo -n ' '
            set_color brmagenta
            echo -n " $branch"

            if test -n "$dirty"
                set_color bryellow
                echo -n "$dirty"
            end

            if test "$unpushed" -gt 0
                set_color brcyan
                echo -n " ↑$unpushed"
            end

            # prio_gate status (cached for 60s, only in autoheim repos)
            set -l _remote (git remote get-url origin 2>/dev/null)
            if string match -q '*gerrit.cicd.autoheim.net*' "$_remote"
                set -l now (date +%s)
                if not set -q __prio_gate_cache; or test (math $now - $__prio_gate_ts) -ge 60
                    set -g __prio_gate_cache (curl -sf -m 3 \
                        'http://main.observability.primary.prod.swf.autoheim.net:8081/prio/src/src' \
                        -H 'accept: application/json' 2>/dev/null \
                        | string match -r '"prio_gate"\s*:\s*"([^"]+)"' | tail -1)
                    set -g __prio_gate_ts $now
                end
                if test -n "$__prio_gate_cache"
                    if test "$__prio_gate_cache" = low; or test "$__prio_gate_cache" = low_prio
                        set_color green
                    else
                        set_color red
                    end
                    echo -n " ($__prio_gate_cache)"
                end
            end

            set_color normal
        end
    end

    # newline + prompt symbol
    echo
    if test $last_status -ne 0
        set_color red
    else
        set_color green
    end
    echo -n '❯ '
    set_color normal
end
