local fzf = require("fzf-lua")

fzf.setup({
    files = {
        no_ignore = false, -- respect ".gitignore" by default
    },
    file_ignore_patterns = {
        ".git/",
        "node_modules",
        "dist",
        -- "build",
        "target",
        "package-lock.json",
        "pnpm-lock.yaml",
        "yarn.lock",
    },
    winopts = {
        preview = {
            hidden = false,
            layout = "vertical",
        },
    },
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files." })
vim.keymap.set("n", "<leader>fg", fzf.git_status, { desc = "Find git status files." })
vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Open buffers." })
vim.keymap.set("n", "<leader>gp", fzf.grep_project, { desc = "Grep project." })
vim.keymap.set("n", "<leader>gl", fzf.live_grep, { desc = "Grep live." })
vim.keymap.set("n", "<leader>gw", fzf.grep_cword, { desc = "Grep word under cursor." })
vim.keymap.set("n", "<leader>gv", fzf.grep_visual, { desc = "Grep visual selection" })
vim.keymap.set("n", "<leader>/", fzf.grep_curbuf, { desc = "Grep current buffer." })
