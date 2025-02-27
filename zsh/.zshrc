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
source "$ZDOTDIR/completions/completion.zsh"
# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/hkuittinen/.config/zsh/completions:"* ]]; then export FPATH="/home/hkuittinen/.config/zsh/completions:$FPATH"; fi

# Aliases
alias {vi,vim}="nvim"
alias lgit="lazygit"
alias image="imv"
alias video="mpv"
