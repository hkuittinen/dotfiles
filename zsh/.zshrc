# Powerlevel10k 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/Projects/dotfiles/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias vim="nvim"
alias lgit="lazygit"

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# To customize prompt, run `p10k configure` or edit ~/Projects/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/Projects/dotfiles/zsh/.p10k.zsh ]] || source ~/Projects/dotfiles/zsh/.p10k.zsh
