# Modern replacements
if command -v eza >/dev/null 2>&1; then
    alias ls='eza'
    alias ll='eza -lbGF --git'
    alias la='eza -lbGFa --git'
    alias l='eza -lbGF --git'
    alias tree='eza --tree'
else
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --style=plain'
    alias bat='bat --theme="Dracula"'
fi

if command -v zoxide >/dev/null 2>&1; then
    alias cd='z'
fi

# Git Aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utils
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias wget='wget -c'

# Antigravity Specific
alias ag-brain='cd ~/.gemini/antigravity/brain'
alias ag-logs='tail -f ~/.gemini/antigravity/logs/agent.log'

# Project Navigation
alias c='cd ~/code'
alias projects='cd ~/code'

# Zoxide "Magic" (allows 'to code')
if command -v zoxide >/dev/null 2>&1; then
    alias to='z'
fi

# Tool Updates
alias update-gentle-ai='go install github.com/gentleman-programming/gentle-ai/cmd/gentle-ai@latest'
