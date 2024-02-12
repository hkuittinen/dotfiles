# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

# Homebrew for macOS
homebrew_path="/opt/homebrew/bin/brew"
if [[ -e $homebrew_path ]]; then 
    eval "$($homebrew_path shellenv)"
fi

