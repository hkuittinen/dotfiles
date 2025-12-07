return {
    -- Git wrapper
    { "tpope/vim-fugitive" },
    -- Git related decorations to the gutter
    {
        "lewis6991/gitsigns.nvim",
        config = function()
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
        end,
    },
    -- Git diff
    {
        "sindrets/diffview.nvim",
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                file_panel = {
                    listing_style = "list", -- 'list' or 'tree'
                    win_config = {
                        width = 35,
                    },
                },
                keymaps = {
                    disable_defaults = true,
                    view = {
                        { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
                        { "n", "f", actions.focus_files, { desc = "Bring focus to the file panel" } },
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
        end,
    },
}
