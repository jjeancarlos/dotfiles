# 🔧 Config

Este repositório contém minhas configurações pessoais de ambiente de desenvolvimento (WSL/Ubuntu), editores de texto e terminal. O objetivo é automatizar a configuração de uma nova máquina para deixá-la pronta para uso rapidamente, com foco em segurança e portabilidade.

## 📂 Estrutura do Repositório

```text
dotfiles/
├── install.sh           # Script de automação (Instala pacotes, linguagens e extensões)
├── README.md            # Este arquivo
├── .bashrc              # Configurações do shell (Alias, Paths, etc)
├── OMP/                 # Temas do Oh My Posh
│   ├── amro.omp.json
│   └── emodipt-extend.omp.json
├── SublimeText/         # Configurações do Sublime Text
│   ├── osaka.sublime-color-scheme
│   └── *.sublime-settings
└── VScode/              # Configurações do VS Code
    ├── extensions.txt   # Lista de backup das extensões
    └── settings.json    # Configurações de usuário (JSON)
````

-----

## 🚀 Instalação Automática (Recomendado)

O script `install.sh` automatiza a atualização do sistema, instalação de ferramentas (Rust, Ruby, etc), configura as extensões do VS Code e ajusta permissões do WSL.

> **🔒 Privacidade:** O script foi ajustado para **não** conter dados sensíveis fixos. Durante a execução, ele solicitará interativamente seu **Nome** e **E-mail** para configurar o Git.

1.  **Clone o repositório:**

    ```bash
    git clone https://github.com/jjeancarlos/dotfiles.git
    ```
    ```bash
    cd dotfiles
    ```

2.  **Dê permissão de execução e rode o script:**

    ```bash
    chmod +x install.sh
    ./install.sh
    ```

3.  **⚠️ Passo Crítico (WSL):**
    O script edita o arquivo `/etc/wsl.conf` para permitir o uso da área de transferência (`clip.exe`) e integração de PATH. Para que isso funcione, você **deve** reiniciar o subsistema completamente.

    Abra o **PowerShell** no Windows e rode:

    ```powershell
    wsl --shutdown
    ```

    Depois, abra seu terminal WSL novamente.

-----

## 🎨 Windows Terminal (Configuração Manual)

Para obter o esquema de cores **Neon**, adicione o seguinte bloco ao seu arquivo `settings.json` do Windows Terminal, dentro da lista `"schemes"`:

\<details\>
\<summary\>Clique para expandir o JSON do Tema Neon\</summary\>

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

\</details\>

-----

## 🛠️ Detalhes das Configurações

### Visual Studio Code

O script de instalação já cuida das extensões e tenta criar o link simbólico para o `settings.json`.

1.  **Tema:** [Noctis Obscuro](https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis)
2.  **Configuração:** O arquivo `VScode/settings.json` é linkado automaticamente para:
      - *WSL (Server):* `~/.vscode-server/data/Machine/settings.json`
      - *Linux Nativo:* `~/.config/Code/User/settings.json`

### Sublime Text

  - **Tema:** Osaka
  - **Diretório dos arquivos:** `SublimeText/`
  - Para instalar manualmente, mova os arquivos desta pasta para:
      - Linux/WSL: `~/.config/sublime-text/Packages/User`
      - Windows: `%APPDATA%\Sublime Text\Packages\User`

### Shell (Bash + Oh My Posh)

  - **Portabilidade:** O `.bashrc` utiliza a variável `$HOME` em vez de caminhos fixos, permitindo que outros usuários utilizem estas configurações.
  - **Integração:** Alias configurados para chamar executáveis do Windows (`subl.exe`, `code`) de dentro do WSL.
  - **Visual:** O tema utilizado é o `amro.omp.json` localizado na pasta `OMP/`.

-----

## 📝 Backup Manual de Extensões

Caso o script falhe ou você queira reinstalar apenas as extensões do VS Code manualmente usando o arquivo de texto:

```bash
cat VScode/extensions.txt | xargs -n 1 code --install-extension
```