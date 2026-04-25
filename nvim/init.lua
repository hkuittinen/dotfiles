require("options")
require("keymaps")
require("autocommands")

vim.pack.add({
    --Dependencies--------------------------------------------------------------
    "https://github.com/nvim-tree/nvim-web-devicons", -- lualine, fzf-lua, oil
    "https://github.com/nvim-lua/plenary.nvim", -- harpoon
    --Plugins-------------------------------------------------------------------
    -- Theme
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    -- Indentation guides
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    -- Detect tabstop and shiftwidth automatically
    "https://github.com/NMAC427/guess-indent.nvim",
    -- Close ([{ etc. automatically
    "https://github.com/windwp/nvim-autopairs",
    -- Close html tags automatically
    "https://github.com/windwp/nvim-ts-autotag",
    -- Center the currently focused buffer
    "https://github.com/shortcuts/no-neck-pain.nvim",
    -- Explore files
    "https://github.com/stevearc/oil.nvim",
    -- Switch files quickly
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
    -- Search
    "https://github.com/ibhagwan/fzf-lua",
    -- Highlight, edit, and navigate code
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    -- LSP
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/stevearc/conform.nvim",
    -- Git
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/sindrets/diffview.nvim",
})
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, {})

vim.api.nvim_create_user_command("PackClean", function()
    vim.pack.del(vim.iter(vim.pack.get())
        :filter(function(x)
            return not x.active
        end)
        :map(function(x)
            return x.spec.name
        end)
        :totable())
end, {})

require("plugins.theme")
require("plugins.indent-blankline")
require("plugins.guess-indent")
require("plugins.nvim-autopairs")
require("plugins.nvim-ts-autotags")
require("plugins.no-neck-pain")
require("plugins.oil")
require("plugins.harpoon")
require("plugins.fzf-lua")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.git")
