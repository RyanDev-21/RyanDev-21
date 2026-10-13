#!/usr/bin/env bash

current=$(tmux display-message -p '#{session_name}')

mapfile -t commands < <(tmux list-panes -s -t "$current" -F '#{pane_current_command}' 2>/dev/null)

for cmd in "${commands[@]}"; do
    if [[ "$cmd" != "zsh" && "$cmd" != "bash" && "$cmd" != "fish" && "$cmd" != "sh" && "$cmd" != "tmux" ]]; then
        tmux display-message -d 3000 "Session $current has running process ($cmd). Kill not permitted."
        exit 1
    fi
done

mapfile -t sessions < <(tmux list-sessions -F '#{session_name}')

if [[ ${#sessions[@]} -le 1 ]]; then
    tmux kill-server
    exit 0
fi

for s in "${sessions[@]}"; do
    if [[ "$s" != "$current" ]]; then
        tmux switch-client -t "$s"
        break
    fi
done

tmux kill-session -t "$current"

mapfile -t remaining < <(tmux list-sessions -F '#{session_name}')
for i in "${!remaining[@]}"; do
    if [[ "${remaining[$i]}" != "$i" ]]; then
        tmux rename-session -t "${remaining[$i]}" "$i"
    fi
done

tmux display-message -d 3000 "Session $current killed; sessions renumbered"
