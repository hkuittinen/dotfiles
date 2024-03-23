vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Better split navigation (currentrly handled by vim-tmux-navigator)
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Splits
vim.keymap.set("n", "<leader>wh", "<cmd>split<CR>")
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>")
vim.keymap.set("n", "<leader>wo", "<cmd>wincmd o<CR>")

vim.keymap.set("n", "=", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "-", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "+", "<cmd>horizontal resize +2<CR>")
vim.keymap.set("n", "_", "<cmd>horizontal resize -2<CR>")
vim.keymap.set("n", "<leader>w=", "<cmd>wincmd =<CR>")

-- Center the cursor on navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Save file
vim.keymap.set("n", "<leader>s", ":update<cr>")

-- Close curret buffer
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- Tabs
vim.keymap.set("n", "<leader>tc", ":tabclose<cr>")
vim.keymap.set("n", "<leader>tn", ":tabnew<cr>")

-- Quit window
vim.keymap.set("n", "<leader>q", ":q<cr>")

-- Open netrw file explorer
vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>")

-- Toggle statusline
vim.keymap.set("n", "<leader>m", function()
    if vim.opt.laststatus:get() == 3 then
        vim.opt.laststatus = 0
        vim.opt.cmdheight = 0
    else
        vim.opt.laststatus = 3
        vim.opt.cmdheight = 1
    end
end)
