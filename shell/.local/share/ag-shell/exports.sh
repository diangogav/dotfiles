# Editors
export EDITOR='code --wait'
export VISUAL='code --wait'

# Path augmentations
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# History control (avoid dupes)
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000

# Color support
export TERM=xterm-256color

# Pager
export PAGER='less'

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ==============================================================================
# FZF Deep Configuration (Freak Mode)
# ==============================================================================
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--layout=reverse \
--border=rounded \
--prompt='🔍 ' \
--pointer='👉' \
--marker='✅' \
--height=40%"

# Use fd (better find) if available, otherwise find
if command -v fd >/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Preview file content using bat (if available) or cat
export FZF_CTRL_T_OPTS=" \
  --preview 'bat -n --color=always --line-range :500 {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ALT-C to cd into directories (with tree preview)
export FZF_ALT_C_OPTS="--preview 'exa --tree --level=2 --color=always {} | head -200'"
