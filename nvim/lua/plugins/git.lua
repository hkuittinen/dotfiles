require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
})

local actions = require("diffview.actions")

local function stage_selected_lines()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
    if vim.api.nvim_buf_get_name(0):match("/%.git/:0:/") then
        -- In the index buffer: pull the selection from the other side into it.
        vim.cmd("'<,'>diffget")
        vim.cmd("silent write")
    else
        -- In the working tree (or HEAD) buffer: push the selection into the
        -- index buffer, then write it.
        vim.cmd("'<,'>diffput")
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.api.nvim_buf_get_name(buf):match("^diffview://") and vim.bo[buf].modified then
                vim.api.nvim_buf_call(buf, function()
                    vim.cmd("silent write")
                end)
            end
        end
    end
end

require("diffview").setup({
    file_panel = {
        listing_style = "list",
        win_config = {
            width = 35,
        },
    },
    keymaps = {
        disable_defaults = true,
        view = {
            { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
            { "n", "f", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "x", "s", stage_selected_lines, { desc = "Stage/unstage the selected lines" } },
        },
        file_panel = {
            { "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
            { "n", "j", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
            { "n", "k", actions.prev_entry, { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
            { "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
            { "n", "S", actions.stage_all, { desc = "Stage all entries" } },
            { "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
            { "n", "D", actions.restore_entry, { desc = "Restore entry to the state on the left side" } },
            { "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
            { "n", "e", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
        },
        help_panel = {
            { "n", "q", actions.close, { desc = "Close help menu" } },
            { "n", "<esc>", actions.close, { desc = "Close help menu" } },
        },
    },
})
vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>dm", "<cmd>DiffviewOpen main...HEAD<CR>")
