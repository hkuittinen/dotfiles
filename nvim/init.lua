require("options")
require("keymaps")
require("autocommands")

-- Install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
    -- Theme and statusline
    require("plugins.active-theme"),

    -- Add a layer of ✨bling✨ and configuration to netrw
    -- NOTE: Using oil.vim currently.
    -- require("plugins.netrw"),

    -- Split windows and the project drawer go together like oil and vinegar
    require("plugins.oil"),

    -- Navigate between vim and tmux splits
    require("plugins.vim-tmux-navigator"),

    -- Highlight, edit, and navigate code
    require("plugins.treesitter"),

    -- Fuzzy Finder (files, lsp, etc)
    require("plugins.telescope"),

    -- Indentation guides
    require("plugins.indent-blankline"),

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- Git related plugins
    require("plugins.git"),

    -- Close ([{ etc. automatically.
    require("plugins.nvim-autopairs"),

    -- Surround with ([{ etc. easily.
    require("plugins.nvim-surround"),

    -- Rainbow parentheses
    -- "HiPhish/rainbow-delimiters.nvim",

    -- Toggle comments
    require("plugins.comment"),

    -- Autocompletion
    require("plugins.nvim-cmp"),

    -- LSP related configs
    require("plugins.lsp"),

    -- Clojure
    require("plugins.clojure"),

    -- Switch files quickly
    require("plugins.harpoon"),

    -- Center the currently focused buffer
    require("plugins.no-neck-pain"),

    -- Markdown
    require("plugins.markdown-preview"),
    require("plugins.markview"),
})
