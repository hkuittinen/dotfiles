# Homebrew for macOS
homebrew_path="/opt/homebrew/bin/brew"
if [[ -e $homebrew_path ]]; then 
    eval "$($homebrew_path shellenv)"
fi

# Fuzzy finder
source <(fzf --zsh)
