return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- options = {
            --     icons_enabled = true,
            --     component_separators = "|",
            --     section_separators = "",
            -- },
        },
    },
    -- Theme
    -- vscode
    {
        "Mofiqul/vscode.nvim",
        priority = 1000,
        config = function()
            require("vscode").load()
            require("lualine").setup({
                options = {
                    theme = "vscode",
                },
            })
        end,
    },
    -- Kanagawa
    -- {
    --     "rebelot/kanagawa.nvim",
    --     config = function()
    --         require("kanagawa").setup({
    --             colors = {
    --                 theme = {
    --                     all = {
    --                         ui = {
    --                             bg_gutter = "none",
    --                         },
    --                     },
    --                 },
    --             },
    --         })
    --         vim.cmd.colorscheme("kanagawa-dragon")
    --     end,
    -- },
}
