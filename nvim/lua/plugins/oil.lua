return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            win_options = {
                -- TODO: Change this to show home path as ~/. Or relative to cwd.
                winbar = "%{v:lua.require('oil').get_current_dir()}",
            },
            view_options = {
                show_hidden = true,
            },
        })
        vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>")
    end,
}
