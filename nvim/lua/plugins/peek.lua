require("peek").setup({
    app = "browser",
})
vim.api.nvim_create_user_command("Preview", require("peek").open, {})
vim.api.nvim_create_user_command("PreviewClose", require("peek").close, {})
