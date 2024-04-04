export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

export EDITOR="nvim"
export VISUAL="nvim"

export ELECTRON_OZONE_PLATFORM_HINT="wayland"

path+=("$HOME/Projects/dotfiles/zsh/scripts")
path+=("$HOME/.local/share/fnm") # Node version manager
export PATH

