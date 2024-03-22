# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

# Node version manager
eval "$(fnm env)"

# Homebrew for macOS
homebrew_path="/opt/homebrew/bin/brew"
if [[ -e $homebrew_path ]]; then 
    eval "$($homebrew_path shellenv)"
fi

