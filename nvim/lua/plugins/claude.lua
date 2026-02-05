return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
        focus_after_send = true,
    },
    keys = {
        -- { "<leader>a", nil, desc = "AI/Claude Code" },
        -- { "<leader>C", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
        { "<C-,>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Toggle Claude" },
        { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude (selec from list)" },
        { "<leader>cc", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude (latest session)" },
        -- { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        -- { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
        { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v" },
        -- {
        --     "<leader>as",
        --     "<cmd>ClaudeCodeTreeAdd<cr>",
        --     desc = "Add file",
        --     ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        -- },
        -- -- Diff management
        -- { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        -- { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
}
