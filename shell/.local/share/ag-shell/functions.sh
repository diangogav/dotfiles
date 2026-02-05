# Create directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# VS Code Extension Management
vscode-save() {
    echo "Saving VS Code extensions to ~/dotfiles/vscode/extensions.txt..."
    code --list-extensions > $HOME/dotfiles/vscode/extensions.txt
    echo "Done! $(wc -l < $HOME/dotfiles/vscode/extensions.txt) extensions saved."
}

vscode-install() {
    if [ -f "$HOME/dotfiles/vscode/extensions.txt" ]; then
        echo "Installing VS Code extensions from list..."
        cat $HOME/dotfiles/vscode/extensions.txt | while read extension; do
            code --install-extension "$extension"
        done
        echo "Done!"
    else
        echo "No extensions.txt found in ~/dotfiles/vscode/"
    fi
}

# Add Alias Helper
# Usage: add-alias name "command"
add-alias() {
    local name=$1
    local command=$2
    local alias_file="$HOME/dotfiles/shell/.local/share/ag-shell/aliases.sh"

    if [ -z "$name" ] || [ -z "$command" ]; then
        echo "Usage: add-alias <name> \"<command>\""
        return 1
    fi

    echo "alias $name='$command'" >> "$alias_file"
    echo "Alias added: $name -> $command"
    
    # Reload aliases
    source "$alias_file"
    echo "Aliases reloaded!"
}
