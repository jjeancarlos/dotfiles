#!/bin/bash

# ==========================================
# INSTALL SCRIPT — ARCH LINUX
# Dotfiles setup
# ==========================================

set -e

echo "🚀 Iniciando instalação do ambiente (Arch Linux)..."

DOTFILES_DIR="$HOME/dotfiles"

# ==========================================
# 0. VERIFICAÇÕES INICIAIS
# ==========================================

if ! command -v pacman &> /dev/null; then
    echo "❌ Este script é exclusivo para Arch Linux."
    exit 1
fi

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Diretório ~/dotfiles não encontrado."
    exit 1
fi

# ==========================================
# 1. ATUALIZAÇÃO DO SISTEMA
# ==========================================

echo "📦 Atualizando sistema..."
sudo pacman -Syu --noconfirm

# ==========================================
# 2. PACOTES OFICIAIS (PACMAN)
# ==========================================

if [ -f "$DOTFILES_DIR/pkglist-official.txt" ]; then
    echo "📦 Instalando pacotes oficiais..."
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist-official.txt"
else
    echo "⚠️  pkglist-official.txt não encontrado. Pulando."
fi

# ==========================================
# 3. AUR (YAY)
# ==========================================

if [ -f "$DOTFILES_DIR/pkglist-aur.txt" ]; then
    if ! command -v yay &> /dev/null; then
        echo "📦 Instalando yay (AUR helper)..."
        sudo pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
        rm -rf /tmp/yay
    fi

    echo "📦 Instalando pacotes AUR..."
    yay -S --needed --noconfirm - < "$DOTFILES_DIR/pkglist-aur.txt"
else
    echo "⚠️  pkglist-aur.txt não encontrado. Pulando."
fi

# ==========================================
# 4. SYMLINKS (.config)
# ==========================================

echo "🔗 Criando symlinks dos dotfiles..."

link_dir() {
    src="$DOTFILES_DIR/.config/$1"
    dest="$HOME/.config/$1"

    if [ ! -d "$src" ]; then
        echo "   [Pular] $1 não existe no dotfiles."
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            echo "   [OK] $1 já linkado."
            return
        fi
        echo "   [Backup] $dest → ${dest}.backup"
        mv "$dest" "${dest}.backup_$(date +%s)"
    fi

    ln -s "$src" "$dest"
    echo "   [Link] $dest → $src"
}

# Lista de configs para linkar
CONFIGS=(
    hypr
    kitty
    rofi
    waybar
    swaylock
    nwg-bar
    nwg-look
    mpv
    pulse
)

for cfg in "${CONFIGS[@]}"; do
    link_dir "$cfg"
done

# ==========================================
# 5. ARQUIVOS SOLTOS EM ~/.config
# ==========================================

link_file() {
    src="$DOTFILES_DIR/.config/$1"
    dest="$HOME/.config/$1"

    if [ ! -f "$src" ]; then
        echo "   [Pular] $1 não existe."
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "   [Backup] $dest → ${dest}.backup"
        mv "$dest" "${dest}.backup_$(date +%s)"
    fi

    ln -s "$src" "$dest"
    echo "   [Link] $dest → $src"
}

link_file "mimeapps.list"
link_file "pavucontrol.ini"

# ==========================================
# 6. FINALIZAÇÃO
# ==========================================

echo ""
echo "🎉 Arch Linux configurado com sucesso!"
echo "➡️  Reinicie a sessão ou o sistema para aplicar tudo."
