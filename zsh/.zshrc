# Prompt
source "$ZDOTDIR/prompt.zsh"

# Vim mode
source "$ZDOTDIR/vim_mode.zsh"

# Turn off beep/bell sound
unsetopt BEEP

# History
setopt SHARE_HISTORY 
setopt HIST_IGNORE_DUPS 

# Completion
source "$ZDOTDIR/completion.zsh"

# Aliases
alias {vi,vim}="nvim"
alias lgit="lazygit"

# Path
path+=("$HOME/Projects/dotfiles/zsh/scripts")
# fnm (Node version manager)
path+=("$HOME/.local/share/fnm")
export PATH

eval "`fnm env`"
