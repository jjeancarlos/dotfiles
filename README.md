# Config 

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
#  Configurações de Editor

Este repositório contém minhas configurações pessoais de editores de texto, incluindo temas, extensões e preferências.

##  Visual Studio Code
- **Tema atual:** [Noctis](https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis)
- Configurações salvas em `settings.json`
- Lista de extensões disponível em `extensions.txt`

##  Sublime Text
- **Tema atual:** Osaka
- Configurações salvas na pasta `Packages/User`

## Como usar
1. Clone este repositório na pasta de configurações do seu editor:
   - VS Code → `~/.config/Code/User` (Linux) ou equivalente no seu sistema
   - Sublime Text → `~/.config/sublime-text/Packages/User` (Linux) ou equivalente no seu sistema
2. Reinicie o editor.
3. Instale as extensões listadas (VS Code):
   ```bash
   cat extensions.txt | xargs -n 1 code --install-extension
