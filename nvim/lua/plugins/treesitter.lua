return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    config = function()
        vim.defer_fn(function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "bash",
                    "python",
                    "tsx",
                    "css",
                    "javascript",
                    "typescript",
                    "html",
                    "svelte",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
                -- "windwp/nvim-ts-autotag",
                autotag = {
                    enable = true,
                },
            })
        end, 0)
    end,
}
