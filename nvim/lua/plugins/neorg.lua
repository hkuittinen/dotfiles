return {
    "nvim-neorg/neorg",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = ":Neorg sync-parsers",
    tag = "v7.0.0",
    lazy = true, -- enable lazy load
    ft = "norg", -- lazy load on file type
    cmd = "Neorg", -- lazy load on command
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/Notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        })
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end,
}
