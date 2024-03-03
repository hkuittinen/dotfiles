vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.virtualedit = "block"

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.pumheight = 10

vim.opt.colorcolumn = "81"

vim.opt.laststatus = 3

vim.opt.mouse = "a"

vim.opt.undofile = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
