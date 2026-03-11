# Created by newuser for 5.9
# Zsh básico
# ---------- Autocomplete ----------
autoload -Uz compinit
compinit

# ---------- History ----------
HISTFILE=/root/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt share_history

# ---------- Aliases ----------
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ---------- Environment ----------
export TERM=xterm-256color
export VIRTUAL_DISABLE_PROMPT=1

# ---------- Oh My Posh ----------
eval "$(oh-my-posh init zsh --config /home/jeanzin/.config/ohmyposh/amro.omp.json)"