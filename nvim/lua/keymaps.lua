vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Splits
---- Create
vim.keymap.set("n", "<leader>wh", "<cmd>split<CR>")
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>")
---- Move
vim.keymap.set("n", "<leader>wH", "<cmd>wincmd H<CR>")
vim.keymap.set("n", "<leader>wJ", "<cmd>wincmd J<CR>")
vim.keymap.set("n", "<leader>wK", "<cmd>wincmd K<CR>")
vim.keymap.set("n", "<leader>wL", "<cmd>wincmd L<CR>")
vim.keymap.set("n", "<leader>wo", "<cmd>wincmd o<CR>")
---- Resize
vim.keymap.set("n", "=", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "-", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "+", "<cmd>horizontal resize +5<CR>")
vim.keymap.set("n", "_", "<cmd>horizontal resize -5<CR>")
vim.keymap.set("n", "<leader>w=", "<cmd>wincmd =<CR>")

-- Center the cursor on navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Save file
vim.keymap.set("n", "<leader>s", "<cmd>update<CR>")

-- Close curret buffer
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>")

-- Tabs
vim.keymap.set("n", "<leader>X", "<cmd>tabclose<CR>")
-- vim.keymap.set("n", "<leader>tc", "<cmd>tabnew<CR>")

-- Quit window
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")

-- Open netrw file explorer
-- NOTE: Using oil.nvim currently.
-- vim.keymap.set("n", "<leader>t", "<cmd>Explore<cr>")

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
