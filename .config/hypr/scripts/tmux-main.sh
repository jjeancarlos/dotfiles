#!/usr/bin/env bash
# Abre uma sessao tmux independente a cada SUPER+Q.
# Sem grouped sessions: cada terminal tem suas proprias janelas e matar uma
# janela/sessao em um terminal nao afeta os outros.
# A sessao e removida ao fechar o kitty por causa do
# "set -g destroy-unattached on" no ~/.tmux.conf.

if ! command -v tmux >/dev/null 2>&1; then
    exec "${SHELL:-/bin/sh}"
fi

exec tmux new-session -s "term-$$-${RANDOM}"
