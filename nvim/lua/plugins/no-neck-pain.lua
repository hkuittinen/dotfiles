return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
        require("no-neck-pain").setup({
            width = 86,
            buffers = {
                wo = {
                    fillchars = "eob: ",
                },
                -- scratchPad = {
                -- 	enabled = true,
                -- 	location = "~/Documents/",
                -- },
                -- bo = {
                -- 	filetype = "md",
                -- },
            },
        })

        vim.keymap.set("n", "<C-Enter>", "<cmd>NoNeckPain<cr>", { desc = "Center buffer." })
    end,
}
