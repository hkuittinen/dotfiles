# Prompt
source "$ZDOTDIR/prompt.zsh"

# Vim mode
source "$ZDOTDIR/vim_mode.zsh"

# Turn off beep/bell sound
unsetopt BEEP

# History
setopt SHARE_HISTORY 
setopt HIST_IGNORE_DUPS 

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Aliases
alias {vi,vim}="nvim"
alias lgit="lazygit"

# Path
path+=("$HOME/Projects/scripts")
# fnm (Node version manager)
path+=("$HOME/.local/share/fnm")
export PATH

eval "`fnm env`"
