autoload -U colors && colors

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'

git_branch() {
    [ ! -z "$vcs_info_msg_0_" ] && echo "%F{red}%f:${vcs_info_msg_0_}"
}

PROMPT=$'%F{blue}%~ $(git_branch) %B\n%F{green}>%f%b '

# Newline before each new prompt
precmd() { print "" }
