#!/bin/bash

# Parar o script se algum comando crítico falhar (exceto verificações if)
set -e

echo "🚀 Iniciando configuração do Dotfiles..."

# ==========================================
# 1. ATUALIZAÇÃO DO SISTEMA
# ==========================================
echo "📦 Atualizando pacotes do sistema..."
sudo apt update && sudo apt upgrade -y

# Instala ferramentas essenciais
# build-essential, libssl-dev, etc são cruciais para compilar Ruby/Rust
sudo apt install -y git curl zsh htop tree build-essential unzip cmake pkg-config libssl-dev

# ==========================================
# 1.1 CONFIGURAÇÃO DO WSL (INTEROP/CLIPBOARD)
# ==========================================
echo "🔧 Verificando configurações do WSL..."

# Verifica se a configuração já existe para evitar duplicidade
if grep -q "appendWindowsPath=true" /etc/wsl.conf 2>/dev/null; then
    echo "   [OK] wsl.conf já está configurado."
else
    echo "   [!] Configurando /etc/wsl.conf para permitir uso do clip.exe..."
    # Escreve no arquivo como root
    sudo bash -c 'cat >> /etc/wsl.conf <<EOF

[interop]
appendWindowsPath=true
EOF'
    echo "   ⚠️  IMPORTANTE: Será necessário rodar 'wsl --shutdown' no Windows ao final."
fi

# ==========================================
# 2. CONFIGURAÇÃO DO GIT (INTERATIVA)
# ==========================================
echo "🔧 Configurando Git..."

# Pergunta os dados para não deixá-los expostos no arquivo do repositório
read -p "Digite o Nome de Usuário para o Git: " git_name
read -p "Digite o E-mail para o Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

# Aumenta buffer para evitar erro em repositórios grandes
git config --global http.postBuffer 524288000

echo "   [OK] Git configurado para $git_name ($git_email)"

# ==========================================
# 3. INSTALAÇÃO DE LINGUAGENS E FERRAMENTAS
# ==========================================

# --- RUST ---
if ! command -v rustup &> /dev/null; then
    echo "🦀 Instalando Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
else
    echo "   [OK] Rust já instalado."
fi

# --- RUBY (rbenv) ---
if [ ! -d "$HOME/.rbenv" ]; then
    echo "💎 Instalando rbenv (Ruby)..."
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    mkdir -p ~/.rbenv/plugins
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    
    # Adiciona ao path temporariamente para uso imediato neste script
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init - bash)"
else
    echo "   [OK] rbenv já instalado."
fi

# --- OH MY POSH ---
if ! command -v oh-my-posh &> /dev/null; then
    echo "🎨 Instalando Oh My Posh..."
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
else
    echo "   [OK] Oh My Posh já instalado."
fi

# ==========================================
# 4. INSTALAÇÃO DE EXTENSÕES VS CODE
# ==========================================
vscode_extensions=(
    "aliariff.vscode-erb-beautify"
    "bceskavich.theme-dracula-at-night"
    "blackboxapp.blackbox"
    "blackboxapp.blackboxagent"
    "bradgashler.htmltagwrap"
    "bradlc.vscode-tailwindcss"
    "craigmaslowski.erb"
    "danielpinto8zz6.c-cpp-compile-run"
    "dart-code.dart-code"
    "dart-code.flutter"
    "docker.docker"
    "dracula-theme.theme-dracula"
    "drcika.apc-extension"
    "esbenp.prettier-vscode"
    "fill-labs.dependi"
    "formulahendry.auto-rename-tag"
    "formulahendry.code-runner"
    "github.copilot"
    "github.copilot-chat"
    "github.vscode-github-actions"
    "hbenl.vscode-test-explorer"
    "icrawl.discord-vscode"
    "illixion.vscode-vibrancy-continued"
    "jackpaget.gruvbox-glass"
    "jnbt.vscode-rufo"
    "kisstkondoros.vscode-gutter-preview"
    "lakshits11.monokai-pirokai"
    "liviuschera.noctis"
    "matthewnespor.vscode-color-identifiers-mode"
    "mechatroner.rainbow-csv"
    "miguelsolorio.fluent-icons"
    "miguelsolorio.min-theme"
    "miguelsolorio.symbols"
    "misogi.ruby-rubocop"
    "ms-azuretools.vscode-containers"
    "ms-azuretools.vscode-docker"
    "ms-ceintl.vscode-language-pack-pt-br"
    "ms-edgedevtools.vscode-edge-devtools"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.vscode-python-envs"
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-toolsai.vscode-jupyter-slideshow"
    "ms-vscode-remote.remote-containers"
    "ms-vscode-remote.remote-wsl"
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "ms-vscode.powershell"
    "ms-vscode.test-adapter-converter"
    "notyasho.ocean-high-contrast"
    "oderwat.indent-rainbow"
    "pkief.material-icon-theme"
    "pmndrs.pmndrs"
    "pranaygp.vscode-css-peek"
    "redhat.java"
    "ritwickdey.liveserver"
    "rubocop.vscode-rubocop"
    "rust-lang.rust-analyzer"
    "saoudrizwan.claude-dev"
    "shopify.ruby-lsp"
    "siriussdev.min-darkest-dracula"
    "sumneko.lua"
    "swellaby.vscode-rust-test-adapter"
    "tal7aouy.icons"
    "tamasfe.even-better-toml"
    "tomoki1207.pdf"
    "twxs.cmake"
    "vadimcn.vscode-lldb"
    "vmware.vscode-boot-dev-pack"
    "vmware.vscode-spring-boot"
    "vscjava.vscode-gradle"
    "vscjava.vscode-java-debug"
    "vscjava.vscode-java-dependency"
    "vscjava.vscode-java-pack"
    "vscjava.vscode-java-test"
    "vscjava.vscode-java-upgrade"
    "vscjava.vscode-maven"
    "vscjava.vscode-spring-boot-dashboard"
    "vscjava.vscode-spring-initializr"
)

if command -v code &> /dev/null; then
    echo "📝 Instalando extensões do VS Code..."
    installed_extensions=$(code --list-extensions)

    for ext in "${vscode_extensions[@]}"; do
        if echo "$installed_extensions" | grep -qi "^$ext$"; then
            echo "   [Pular] $ext já instalada."
        else
            echo "   [Instalando] $ext..."
            code --install-extension "$ext" --force > /dev/null
        fi
    done
else
    echo "⚠️  Comando 'code' não encontrado. Certifique-se de que o VS Code está instalado no Windows e integrado ao WSL."
fi

# ==========================================
# 5. SYMLINKS (CONFIGURAÇÕES)
# ==========================================
echo "🔗 Linkando arquivos de configuração..."

link_dotfile() {
    src="$HOME/dotfiles/$1"
    dest="$2"
    mkdir -p "$(dirname "$dest")"

    if [ -f "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            echo "   [OK] $1 já está linkado."
            return
        fi
        echo "   [Backup] Movendo $dest para ${dest}.backup"
        mv "$dest" "${dest}.backup_$(date +%s)"
    fi
    ln -s "$src" "$dest"
    echo "   [Link] Criado: $dest -> $src"
}

# Linkar .bashrc
link_dotfile ".bashrc" "$HOME/.bashrc"

# Tentar linkar settings.json do VS Code
vscode_settings_path="$HOME/.vscode-server/data/Machine/settings.json"
if [ ! -d "$(dirname "$vscode_settings_path")" ]; then
    vscode_settings_path="$HOME/.config/Code/User/settings.json"
fi

if [ -f "$HOME/dotfiles/VScode/settings.json" ]; then
    echo "   Tentando configurar settings.json do VS Code..."
    link_dotfile "VScode/settings.json" "$vscode_settings_path"
fi

echo ""
echo "🎉 Configuração finalizada!"
echo "⚠️  ATENÇÃO: Para ativar o clip.exe e path, rode no PowerShell:"
echo "   wsl --shutdown"