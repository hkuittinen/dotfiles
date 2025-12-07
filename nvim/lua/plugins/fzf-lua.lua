return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        files = {
            no_ignore = false, -- respect ".gitignore"  by default
        },
        file_ignore_patterns = {
            ".git",
            "node_modules",
            "dist",
            "build",
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
    },
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find files.",
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "Find git status files.",
        },
        {
            "<leader><leader>",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Open buffers.",
        },
        {
            "<leader>gp",
            function()
                require("fzf-lua").grep_project()
            end,
            desc = "Grep project.",
        },
        {
            "<leader>gl",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Grep live.",
        },
        {
            "<leader>gw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "Grep word under cursor.",
        },
        {
            "<leader>gv",
            function()
                require("fzf-lua").grep_visual()
            end,
            desc = "Grep visual selection",
        },
        {
            "<leader>/",
            function()
                require("fzf-lua").grep_curbuf()
            end,
            desc = "Grep current buffer.",
        },
    },
}
