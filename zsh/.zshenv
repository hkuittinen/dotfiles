export XDG_CONFIG_HOME="$HOME/.config"

export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

export EDITOR="nvim"
export VISUAL="nvim"

export ELECTRON_OZONE_PLATFORM_HINT="wayland"

# Node version manager
eval "$(fnm env --shell zsh)"

path+=("$HOME/projects/dotfiles/zsh/scripts")
# . "/home/hkuittinen/.deno/env"
