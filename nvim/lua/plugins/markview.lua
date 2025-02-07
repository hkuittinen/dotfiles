return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        require("markview").setup({
            markdown = {
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
            },
            markdown_inline = {
                checkboxes = {
                    enable = false,
                },
            },
        })
    end,
}
