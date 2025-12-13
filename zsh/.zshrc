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

# Node version manager
eval "$(fnm env --use-on-cd --shell zsh)"

# Aliases
alias {vi,vim}="nvim"
alias lgit="lazygit"
alias image="imv"
alias video="mpv"
alias pwdc="pwd | wl-copy"
alias soulseek="nicotine"
alias wifi="impala"
alias bluetooth="bluetui"
alias usb="bashmount"
