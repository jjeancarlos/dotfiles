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
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PATH="$HOME/.npm-global/bin:$PATH"

# ---------- Oh My Posh ----------
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/amro.omp.json)"

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

# Claude Code

# export ANTHROPIC_AUTH_TOKEN="sk-xxxxxxxxxxxxxx"
export ANTHROPIC_API_KEY="sk-xxxxxxxxxxxx"
export ANTHROPIC_BASE_URL="https://api.claude-web.dev"

git-ai() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "❌ Você não está dentro de um repositório Git."
        return 1
    fi

    if git diff --cached --quiet; then
        echo "❌ Nenhuma alteração staged."
        echo "Use: git add ."
        return 1
    fi

    echo "🤖 Analisando histórico e alterações..."
    echo

    local history
    history=$(git log -20 --pretty=format:"%s" 2>/dev/null)

    local diff
    diff=$(git diff --cached --no-ext-diff)

    local prompt
    prompt=$(cat <<EOF
You are generating a Git commit message for the current repository.

Analyze BOTH:
1. The repository's recent commit history.
2. The currently staged changes.

Recent commit messages:
$history

Staged changes:
$diff

Your task:
- Infer the commit message style used by this repository.
- Follow the repository's existing conventions whenever possible.
- If the repository uses Conventional Commits, follow that format.
- If it uses scopes, prefixes, capitalization or another pattern, imitate it.
- Describe what actually changed, not what you assume was intended.
- Keep the message concise.
- Generate ONE commit message only.
- Return ONLY the commit message.
- Do not use Markdown.
- Do not use quotes.
- Do not add explanations.
EOF
)

    local message
    message=$(copilot -p "$prompt" -s 2>/dev/null)

    if [[ -z "$message" ]]; then
        echo "❌ Não foi possível gerar a mensagem."
        return 1
    fi

    # Remove possíveis aspas ou espaços extras
    message="${message#"${message%%[![:space:]]*}"}"
    message="${message%"${message##*[![:space:]]}"}"
    message="${message#\"}"
    message="${message%\"}"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📝 Commit sugerido:"
    echo
    echo "   $message"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo

    local confirm
    read "confirm?Criar este commit? [Y/n/e] "

    case "$confirm" in
        [Yy]|"")
            git commit -m "$message"
            ;;
        [Ee]|[Ee][Dd][Ii][Tt])
            local edited
            vared -p "Mensagem: " -c message
            git commit -m "$message"
            ;;
        *)
            echo "❌ Commit cancelado."
            ;;
    esac
}