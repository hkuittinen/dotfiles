local fzf = require("fzf-lua")

local exclude_dirs = {
    ".git",
    ".cache",
    ".venv",
    "node_modules",
    "dist",
    "target",
}

---@param exclude_flag string the tool's exclusion flag, "%s" is the directory
local function excludes(exclude_flag)
    return table.concat(
        vim.tbl_map(function(dir)
            return exclude_flag:format(dir)
        end, exclude_dirs),
        " "
    )
end

fzf.setup({
    files = {
        no_ignore = true, -- "Don't use .gitignore".
        hidden = true, -- dotfiles
        fd_opts = "--color=never --type f --type l " .. excludes("--exclude %s"),
        rg_opts = "--color=never --files " .. excludes('-g "!%s"'),
    },
    grep = {
        no_ignore = true,
        hidden = true,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case " .. "--max-columns=4096 " .. excludes('-g "!%s"') .. " -e",
    },
    -- Lua patterns.
    file_ignore_patterns = {
        "package%-lock%.json$",
        "pnpm%-lock%.yaml$",
        "yarn%.lock$",
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
