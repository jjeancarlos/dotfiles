# Created by newuser for 5.9
# Zsh básico
# ---------- Autocomplete ----------
autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump

# ---------- History ----------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history

# ---------- key binds --------
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---------- Aliases ----------
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ---------- Environment ----------
export TERM=xterm-256color
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# ---------- Oh My Posh ----------
eval "$(oh-my-posh init zsh --config 'amro')"

# ---------- Autosuggestions ----------
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---------- fzf ----------
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# ---------- Syntax Highlighting ----------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Home → início da linha
bindkey "^[[H" beginning-of-line

# End → fim da linha
bindkey "^[[F" end-of-line

# DEL → apaga toda a linha
bindkey "^[[3~" kill-whole-line

if ! ssh-add -l &>/dev/null; then
    ssh-add ~/.ssh/id_ed25519
fi