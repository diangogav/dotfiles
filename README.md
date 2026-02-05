# 👽 Modern & Freak Dotfiles

Configuración de dotfiles moderna, rápida y modular para Linux, manejada con **GNU Stow**.

## ✨ Características

- **Shell**: Zsh + [Starship](https://starship.rs) (Tema "Freak" con emojis).
- **Gestor**: GNU Stow para symlinks limpios.
- **Tools**:
    - **FZF**: Búsquedas profundas (`Ctrl+R`, `Ctrl+T`) con preview.
    - **Zoxide**: Navegación inteligente (`z`, `to code`).
    - **Exa/Bat**: Reemplazos modernos para `ls` y `cat`.
- **VS Code**: Settings listas y scripts de backup/restore.

## 🚀 Instalación

```bash
# 1. Clonar el repo
git clone https://github.com/TU_USUARIO/dotfiles.git ~/dotfiles

# 2. Entrar y ejecutar script
cd ~/dotfiles
./install.sh
```

## 📂 Estructura

- `install.sh`: Script mágico que instala dependencias y hace el stowing.
- `zsh/`: Configuración de `.zshrc`.
- `shell/`: Alias y funciones compartidas.
- `vscode/`: Lista de extensiones y settings.

## 🛠️ Comandos Utiles

- `vscode-save`: Guardar extensiones instaladas.
- `vscode-install`: Restaurar extensiones.
- `to code` / `c`: Ir a la carpeta de proyectos.
