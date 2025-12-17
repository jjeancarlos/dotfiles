# 🔧 Config

Este repositório contém minhas configurações pessoais de ambiente de desenvolvimento (WSL/Ubuntu e Arch Linux), editores de texto e terminal. O objetivo é automatizar a configuração de uma nova máquina para deixá-la pronta para uso rapidamente, com foco em segurança e portabilidade.

## 📂 Estrutura do Repositório

```text
dotfiles/
├── .config/             # Configurações de interface gráfica (WM, Terminais, etc.)
│   ├── hypr/            # Hyprland (Tiling Window Manager)
│   ├── kitty/           # Terminal moderno acelerado por GPU
│   ├── nwg-bar/         # Menu de saída GTK
│   ├── rofi/            # Launcher de apps e gerenciador de janelas
│   ├── swaylock/        # Tela de bloqueio estilizada
│   └── waybar/          # Barra de status altamente personalizável
├── OMP/                 # Temas do Oh My Posh
├── SublimeText/         # Configurações do Sublime Text
├── VScode/              # Configurações do VS Code
├── .bashrc              # Configurações do shell
├── install-arch.sh      # Script de setup focado em Arch Linux
├── install.sh           # Script de setup focado em WSL/Ubuntu
├── pkglist.txt          # Lista consolidada de pacotes (Pacman/AUR)
└── README.md            # Documentação do projeto

```

---

## 🚀 Instalação Automática

### 1. No WSL ou Ubuntu

O script `install.sh` foca em pacotes `apt`, ferramentas de dev (Rust, Ruby) e ajustes de integração com o Windows.

```bash
chmod +x install.sh && ./install.sh

```

### 2. No Arch Linux (Nativo)

O script `install-arch.sh` é voltado para a instalação do ambiente desktop e utilitários de sistema via `pacman` e `yay`.

```bash
chmod +x install-arch.sh && ./install-arch.sh

```

> **⚠️ Passo Crítico (WSL):** Se estiver no WSL, após rodar o script, abra o **PowerShell** e execute `wsl --shutdown` para aplicar as mudanças de rede e sistema.

---

## 🐧 Arch Linux & Hyprland

Adicionei suporte para uma instalação completa de ambiente gráfico baseado em **Wayland**:

* **`.config/`**: Contém os arquivos de "rice" (estética). Aqui estão as definições de atalhos do **Hyprland**, o visual da **Waybar** e a configuração do terminal **Kitty**.
* **`pkglist.txt`**: Um arquivo de texto contendo todos os pacotes essenciais para o sistema. Isso facilita a migração: em vez de instalar um por um, o script lê esta lista.
* **`install-arch.sh`**: Script que automatiza a leitura do `pkglist.txt`, instala um AUR helper (como o `yay`) e cria os links simbólicos das pastas de configuração para o seu `~/.config`.

---

## 🎨 Windows Terminal (Configuração Manual)

Para obter o esquema de cores **Neon**, adicione o seguinte bloco ao seu arquivo `settings.json` do Windows Terminal, dentro da lista `"schemes"`:

```json
{
    "background": "#000000",
    "black": "#000000",
    "blue": "#0208CB",
    "brightBlack": "#686868",
    "brightBlue": "#3C40CB",
    "brightCyan": "#88FFFE",
    "brightGreen": "#75FF88",
    "brightPurple": "#F15BE5",
    "brightRed": "#FF5A5A",
    "brightWhite": "#FFFFFF",
    "brightYellow": "#FFFD96",
    "cursorColor": "#C7C7C7",
    "cyan": "#00FFFC",
    "foreground": "#00FFFC",
    "green": "#5FFA74",
    "name": "Neon",
    "purple": "#F924E7",
    "red": "#FF3045",
    "selectionBackground": "#0013FF",
    "white": "#C7C7C7",
    "yellow": "#FFFC7E"
}

```

---

## 🛠️ Detalhes das Configurações

### Visual Studio Code

* **Tema:** [Noctis Obscuro](https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis)
* **Links Simbólicos:** O script vincula automaticamente o `VScode/settings.json` para o diretório correto no WSL ou Linux Nativo.

### Sublime Text

* **Tema:** Osaka
* **Localização:** Arquivos em `SublimeText/` devem ser linkados para `Packages/User`.

### Shell (Bash + Oh My Posh)

* **Portabilidade:** O `.bashrc` utiliza a variável `$HOME` em vez de caminhos fixos.
* **Visual:** O tema padrão é o `amro.omp.json` dentro da pasta `OMP/`.

---

## 📝 Backup Manual de Extensões

Para reinstalar as extensões do VS Code manualmente:

```bash
cat VScode/extensions.txt | xargs -n 1 code --install-extension

```