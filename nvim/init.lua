require("options")
require("keymaps")
require("autocommands")

-- Install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
    -- Theme and statusline
    require("plugins.active-theme"),

    -- Indentation guides
    require("plugins.indent-blankline"),

    -- Detect tabstop and shiftwidth automatically
    require("plugins.guess-indent"),

    -- Close ([{ etc. automatically.
    require("plugins.nvim-autopairs"),

    -- Center the currently focused buffer
    require("plugins.no-neck-pain"),

    -- Explore files
    require("plugins.oil"),

    -- Switch files quickly
    require("plugins.harpoon"),

    -- Search
    require("plugins.fzf-lua"),

    -- Highlight, edit, and navigate code
    require("plugins.treesitter"),

    -- LSP related configs
    require("plugins.lsp"),

    -- Git related configs
    require("plugins.git"),
})
