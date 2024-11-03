return {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("markview").setup({
            headings = {
                shift_width = 0,
                heading_1 = {
                    style = "label",
                    sign = "",
                    padding_right = " ",
                    icon = "# ",
                },
                heading_2 = {
                    style = "label",
                    sign = "",
                    padding_right = " ",
                    icon = "## ",
                },
                heading_3 = {
                    style = "label",
                    sign = "",
                    padding_right = " ",
                    icon = "### ",
                },
            },
            list_items = {
                enable = false,
            },
            checkboxes = {
                enable = false,
            },
            code_blocks = {
                sign = false,
            },
        })
    end,
}
