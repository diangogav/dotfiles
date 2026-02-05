# ==============================================================================
# Modern Bash Configuration
# ==============================================================================

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 1. Exports
if [ -f "$HOME/.local/share/ag-shell/exports.sh" ]; then
    source "$HOME/.local/share/ag-shell/exports.sh"
fi

# 2. Aliases & Functions
if [ -f "$HOME/.local/share/ag-shell/aliases.sh" ]; then
    source "$HOME/.local/share/ag-shell/aliases.sh"
fi
if [ -f "$HOME/.local/share/ag-shell/functions.sh" ]; then
    source "$HOME/.local/share/ag-shell/functions.sh"
fi

# 3. Tools Initialization
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# The Fuck (Disabled)
# if command -v thefuck >/dev/null 2>&1; then
#     eval $(thefuck --alias)
#     eval $(thefuck --alias fuck)
# fi

# FZF (Deep Integration)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
else
    # Fallback prompt
    PS1='\u@\h:\w\$ '
fi
