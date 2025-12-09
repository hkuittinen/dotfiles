return {
    "stevearc/quicker.nvim",
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
        on_qf = function(bufnr)
            vim.keymap.set("n", "<cr>", "<cr><cmd>cclose<cr>", {
                buffer = bufnr,
                noremap = true,
                silent = true,
            })
        end,
    },
}
