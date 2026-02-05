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
