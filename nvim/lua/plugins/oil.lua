return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local oil = require("oil")

        function OIL_GET_WINBAR()
            local dir = oil.get_current_dir():gsub(vim.fn.getenv("HOME"), "~")
            local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return dir .. " [cwd:" .. cwd_name .. "]"
        end

        oil.setup({
            win_options = {
                winbar = "%{v:lua.OIL_GET_WINBAR()}",
            },
            view_options = {
                show_hidden = true,
            },
        })

        vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>")
    end,
}
