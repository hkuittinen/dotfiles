vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Better split navigation (currentrly handled by vim-tmux-navigator)
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Center the cursor on navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste without replacing the yanked text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Save file
vim.keymap.set("n", "<leader>s", ":update<cr>")

-- Close curret buffer
vim.keymap.set("n", "<leader>w", ":bd<cr>")

-- Quit window
vim.keymap.set("n", "<leader>q", ":q<cr>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open netrw file explorer
vim.keymap.set("n", "<leader>t", "<cmd>Explore<cr>")
