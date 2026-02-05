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
        sudo apt-get install -y stow zsh git curl
    elif command -v dnf >/dev/null; then
        sudo dnf install -y stow zsh git curl
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
    PACKAGES=(shell zsh bash starship git bin vscode)
    
    for pkg in "${PACKAGES[@]}"; do
        log "Linking $pkg..."
        stow -R $pkg
    done
}

# Main
install_dependencies
run_stow

log "Done! Please restart your shell or run 'zsh'."
