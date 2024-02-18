return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 50,
            },
            filters = {
                git_ignored = false,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = false,
                    },
                    git_placement = "after",
                },
            },
        })
    end,
}
