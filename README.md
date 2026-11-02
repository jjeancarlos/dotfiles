# 🔧 Config

Este repositório contém minhas configurações pessoais de ambiente de desenvolvimento (WSL/Ubuntu e Arch Linux), editores de texto e terminal. O objetivo é automatizar a configuração de uma nova máquina para deixá-la pronta para uso rapidamente, com foco em segurança, produtividade e portabilidade.

---

## 📂 Estrutura do Repositório

```text
dotfiles/
├── .config/             # Configurações de interface gráfica (WM, Terminais, etc.)
│   ├── hypr/            # Hyprland (Tiling Window Manager)
│   ├── kitty/           # Terminal moderno acelerado por GPU
│   ├── nwg-bar/         # Menu de saída GTK
│   ├── rofi/            # Launcher de apps e gerenciador de janelas
│   ├── swaylock/        # Tela de bloqueio estilizada
│   ├── waybar/          # Barra de status altamente personalizável
│   └── zsh/             # Configuração do Zsh (shell principal no Arch)
├── OMP/                 # Temas do Oh My Posh
├── SublimeText/         # Configurações do Sublime Text
├── VScode/              # Configurações do VS Code
├── .bashrc              # Configurações do Bash (WSL / fallback)
├── install-arch.sh      # Script de setup focado em Arch Linux
├── install.sh           # Script de setup focado em WSL/Ubuntu
├── pkglist.txt          # Lista consolidada de pacotes (Pacman/AUR)
├── pkglist-official.txt # Pacotes explícitos dos repositórios oficiais
├── pkglist-aur.txt      # Pacotes explícitos do AUR
└── README.md            # Documentação do projeto
````

---

## 🚀 Instalação Automática

### 1. No WSL ou Ubuntu

O script `install.sh` foca em pacotes `apt`, ferramentas de dev (Rust, Ruby) e ajustes de integração com o Windows.
Neste ambiente, o **Bash é mantido como shell padrão**.

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

* **`.config/`**: Contém os arquivos de "rice" (estética). Aqui estão as definições de atalhos do **Hyprland**, o visual da **Waybar**, do terminal **Kitty** e do **Zsh**.
* **`pkglist.txt`**: Lista consolidada com todos os pacotes explícitos do sistema.
* **`pkglist-official.txt`** / **`pkglist-aur.txt`**: Listas separadas usadas pelo instalador (pacotes oficiais e AUR).
* **`install-arch.sh`**: Script que lê as listas separadas, instala os pacotes via `pacman`/`yay` e cria os links simbólicos necessários.

---

## 🐚 Shell (Zsh + Bash + Oh My Posh)

### Zsh (Shell principal no Arch Linux)

No Arch Linux, o **Zsh é utilizado como shell padrão**, com foco em produtividade e usabilidade.

**Recursos configurados:**

* Autocomplete avançado (`compinit`)
* Histórico compartilhado e incremental
* Autosuggestions
* Syntax highlighting
* Integração com `fzf`
* Prompt customizado com **Oh My Posh**

📁 Arquivos:

* `~/.config/zsh/.zshrc`
* `~/.config/zsh/plugins.zsh`
* Temas em `OMP/`
* Credenciais locais: `~/.config/secrets.zsh` (permissão `600`, fora do Git)

Após clonar o repositório:

```bash
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
chsh -s /bin/zsh
```

---

### Bash (WSL / Fallback)

O Bash continua presente para:

* WSL / Ubuntu
* Ambientes mínimos
* Compatibilidade

**Características:**

* Portável
* Usa `$HOME` em vez de caminhos fixos
* Compartilha o mesmo tema do Oh My Posh (`amro.omp.json`)

Arquivo:

* `.bashrc`

---

## 🎨 Windows Terminal (Configuração Manual)

Para obter o esquema de cores **Neon**, adicione o seguinte bloco ao seu arquivo `settings.json` do Windows Terminal, dentro da lista `"schemes"`:

```json
{
  "name": "Neon",
  "background": "#000000",
  "foreground": "#00FFFC",
  "cursorColor": "#C7C7C7",
  "selectionBackground": "#0013FF",
  "black": "#000000",
  "red": "#FF3045",
  "green": "#5FFA74",
  "yellow": "#FFFC7E",
  "blue": "#0208CB",
  "purple": "#F924E7",
  "cyan": "#00FFFC",
  "white": "#C7C7C7",
  "brightBlack": "#686868",
  "brightRed": "#FF5A5A",
  "brightGreen": "#75FF88",
  "brightYellow": "#FFFD96",
  "brightBlue": "#3C40CB",
  "brightPurple": "#F15BE5",
  "brightCyan": "#88FFFE",
  "brightWhite": "#FFFFFF"
}
```

---

## 🛠️ Detalhes das Configurações

### Visual Studio Code

* **Tema:** Noctis Obscuro
* **Links simbólicos:** Criados automaticamente pelos scripts

### Sublime Text

* **Tema:** Osaka
* **Arquivos:** `SublimeText/ → Packages/User`

---

## 📝 Backup Manual de Extensões (VS Code)

```bash
cat VScode/extensions.txt | xargs -n 1 code --install-extension
```
