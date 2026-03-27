# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# Modern Zsh Configuration
# ==============================================================================

# 1. Exports
source $HOME/.local/share/ag-shell/exports.sh

# 2. History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# 3. Zsh Options
setopt AUTOCD              # Input directory name to cd
setopt CORRECT             # Auto correct mistakes
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shell

# 4. Plugins (Manual Sourcing or Antibody/Zinit placeholder)
# For now we use standard zsh behavior + fzf/zoxide/starship initialization

# 5. Aliases & Functions
source $HOME/.local/share/ag-shell/aliases.sh
source $HOME/.local/share/ag-shell/functions.sh

# 6. Tools Initialization
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# The Fuck (Disabled)
# if command -v thefuck >/dev/null 2>&1; then
#     eval $(thefuck --alias)
#     eval $(thefuck --alias fuck)
# fi

# FZF (Deep Integration)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 7. Zinit Plugin Manager & Plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Extend Zinit functionality
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Essential Plugins
zinit light zsh-users/zsh-completions
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-history-substring-search

# Fzf-Tab (deeply integrates fzf with zsh's tab completion)
zinit light Aloxaf/fzf-tab

# Autosuggestions and Syntax Highlighting (MUST be the last plugins to load)
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# Initialize completion system (must be done after adding to fpath)
autoload -Uz compinit
compinit

# 8. Greeting
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

