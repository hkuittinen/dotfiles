return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
        },
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- NOTE: If you are having trouble with this installation,
            -- refer to the README for telescope-fzf-native for more instructions.
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
        },
    },
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "vertical",
                file_ignore_patterns = { ".git/", "node_modules" },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                grep_string = {
                    additional_args = { "--hidden" },
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>gw", builtin.grep_string, {})
        vim.keymap.set("n", "<leader><space>", builtin.buffers, {})
    end,
}
