#!/usr/bin/env bash
set -euo pipefail

export FZF_DEFAULT_OPTS_FILE="${FZF_DEFAULT_OPTS_FILE:-$HOME/.config/fzf/fzf.conf}"

selection=$(
    tmux list-windows -a -F '#{session_name}:#{window_index} #{window_name}' |
        fzf --no-height \
            --header='tmux windows' \
            --preview 'tmux capture-pane -ep -t {1} | tail -n 40' \
            --preview-window='right:55%:wrap'
) || exit 0

[[ -z $selection ]] && exit 0

target=${selection%% *}
tmux switch-client -t "${target%%:*}"
tmux select-window -t "$target"
