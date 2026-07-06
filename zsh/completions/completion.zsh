zmodload zsh/complist

# Use hjlk in menu selection (during completion)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Custom completions (deno, etc.) must be on fpath *before* compinit runs.
fpath=("$ZDOTDIR/completions" $fpath)

# Load the completion system. Rebuilding the dump and running the security
# audit on every startup is what makes this slow, so only do the full rebuild
# once a day; otherwise reuse the cached dump with -C (skips scan + audit).
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n $_zcompdump(Nmh+24) ]]; then
  compinit -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompdump

_comp_options+=(globdots) # With hidden files

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
