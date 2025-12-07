# Neovim

## Linux

```
ln -s ~/projects/dotfiles/nvim ~/.config/nvim
```

## Windows PowerShell

```
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim\ -Target "C:\projects\dotfiles\nvim"
```
