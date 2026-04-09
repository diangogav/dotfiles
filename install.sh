#!/bin/bash

# Modern Dotfiles Installer
# Uses Stow to symlink configuration files.

set -e

# Helpers
log() {
    echo -e "\033[1;34m[DOTFILES]\033[0m $1"
}

# 1. Install Dependencies (Debian/Ubuntu/Fedora detection basic)
install_dependencies() {
    log "Checking dependencies..."

    if command -v apt-get >/dev/null; then
        # Try update, but don't fail properly (broken PPAs are common)
        sudo apt-get update || echo "Warning: apt-get update failed. Attempting to install packages anyway..."
        sudo apt-get install -y stow zsh git curl fastfetch direnv neovim ripgrep fd-find
    elif command -v dnf >/dev/null; then
        sudo dnf install -y stow zsh git curl direnv neovim ripgrep fd-find
    else
        log "Warning: Could not detect package manager. Please install 'stow' and 'zsh' manually."
    fi

    # Install Starship if missing
    if ! command -v starship >/dev/null; then
        log "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi

    # Install Zoxide if missing
    if ! command -v zoxide >/dev/null; then
        log "Installing Zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi

    # The Fuck installation removed by user request (compatibility issues)
    # if ! command -v thefuck >/dev/null || [[ $(command -v thefuck) == "/usr/bin/thefuck" ]]; then
    #    ...
    # fi

    # Fix Locales (prevent perl warnings)
    if command -v localedef >/dev/null; then
        log "Generating locales..."
        sudo locale-gen en_US.UTF-8 || true
        sudo update-locale LANG=en_US.UTF-8 || true
    fi

    # Install Mise (Universal Version Manager - Node, Python, etc.)
    if ! command -v mise >/dev/null; then
        log "Installing Mise..."
        curl https://mise.run | sh
    fi

    # FZF Deep Integration
    # Remove system fzf (too old, conflicts with git version)
    if command -v fzf >/dev/null && [[ $(command -v fzf) == "/usr/bin/fzf" ]]; then
        log "Removing system fzf (too old)..."
        if command -v apt-get >/dev/null; then
            sudo apt-get remove -y fzf || true
        fi
    fi

    # Install FZF (Deep integration via Git)
    if [ ! -d "$HOME/.fzf" ]; then
        log "Installing FZF (Git Method for deep integration)..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi

    # Zsh plugins are now managed directly in .zshrc via Zinit.
}

# 2. Run Stow
run_stow() {
    log "Stowing packages..."

    # Ensure targets exist
    mkdir -p ~/.config
    mkdir -p ~/.local/bin
    mkdir -p ~/.local/share
    mkdir -p ~/.config/Code/User

    # Backup existing files to avoid stow conflicts
    backup_if_exists() {
        if [ -f "$1" ] && [ ! -L "$1" ]; then
            log "Backing up existing $1 to $1.bak"
            mv "$1" "$1.bak"
        fi
    }

    backup_if_exists "$HOME/.zshrc"
    backup_if_exists "$HOME/.bashrc"
    backup_if_exists "$HOME/.gitconfig"
    backup_if_exists "$HOME/.config/starship.toml"
    backup_if_exists "$HOME/.config/Code/User/settings.json"

    # Packages to stow
    PACKAGES=(shell zsh bash starship git bin vscode warp opencode antigravity ghostty zellij nvim)

    for pkg in "${PACKAGES[@]}"; do
        log "Linking $pkg..."
        stow -R $pkg
    done

    # Restore VS Code extensions if listing exists
    if [ -f "$HOME/dotfiles/vscode/extensions.txt" ] && command -v code >/dev/null; then
        log "Installing VS Code extensions..."
        # We run it in background or sequentially? Sequentially is safer but slower.
        # Check if the list is non-empty
        if [ -s "$HOME/dotfiles/vscode/extensions.txt" ]; then
            cat "$HOME/dotfiles/vscode/extensions.txt" | xargs -L 1 code --install-extension >/dev/null 2>&1 || true
            log "VS Code extensions installed."
        fi
    fi
}

# 3. Setup GNOME Preferences
setup_gnome_preferences() {
    if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
        log "Setting GNOME wallpaper and screensaver..."
        gsettings set org.gnome.desktop.background picture-uri "file://$HOME/dotfiles/wallpapers/the-super-mario.jpg"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$HOME/dotfiles/wallpapers/the-super-mario.jpg"
        gsettings set org.gnome.desktop.screensaver picture-uri "file://$HOME/dotfiles/wallpapers/the-super-mario.jpg"
    fi
}

# Main
install_dependencies
run_stow
setup_gnome_preferences

log "Done! Please restart your shell or run 'zsh'."
