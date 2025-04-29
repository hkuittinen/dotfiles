function Get-GitBranch {
    $gitBranch = $(git rev-parse --abbrev-ref HEAD 2>$null)
    if ($gitBranch) {
        return "`e[31m`e[0m:$gitBranch" # Red icon: nf-pl-branch (Nerd Font)
    } else {
        return ""
    }
}

function prompt {
    $gitBranch = Get-GitBranch
    $workingDir = "`e[34m$PWD`e[0m" # Blue 
    $inputArrow= "`e[32m>`e[0m" # Green
    return "PS $workingDir $($gitBranch)`n$inputArrow "
}

Set-Alias vim nvim
