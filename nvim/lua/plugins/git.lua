return {
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
                attach_to_untracked = true,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Actions
                    map("n", "<leader>gh", gs.preview_hunk)
                    -- map("n", "<leader>dt", gs.diffthis)
                    map("n", "<leader>gb", function()
                        gs.blame_line({ full = true })
                    end)
                end,
            })
        end,
    },
    -- Git diff view
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview").setup({})
            vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<cr>")
        end,
    },
    -- Git status etc.
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            require("neogit").setup({})
            vim.keymap.set("n", "<leader>gs", ":Neogit<cr>")
        end,
    },
}
