require("no-neck-pain").setup({
    width = 100,
    autocmds = {
        enableOnVimEnter = true,
    },
    buffers = {
        wo = {
            fillchars = "eob: ",
        },
        -- scratchPad = {
        -- 	enabled = true,
        -- 	location = "~/scratchpad/",
        -- },
        -- bo = {
        -- 	filetype = "md",
        -- },
    },
})
vim.keymap.set("n", "<leader>\\", "<cmd>NoNeckPain<cr>", { desc = "Center buffer." })
