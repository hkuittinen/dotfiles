return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "lua",
            "javascript",
            "jsx",
            "typescript",
            "tsx",
            "html",
            "css",
            "go",
            "markdown",
            "markdown_inline",
            "vim",
            "vimdoc",
            "bash",
            "zsh",
            "sql",
            "python",
            "c",
        })
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local treesitter = require("nvim-treesitter")
                local lang = vim.treesitter.language.get_lang(args.match)
                if vim.list_contains(treesitter.get_available(), lang) then
                    if not vim.list_contains(treesitter.get_installed(), lang) then
                        print("Treesitter parser not installed: " .. lang)
                        return
                        -- To auto install:
                        -- treesitter.install(lang):wait()
                    end
                    vim.treesitter.start(args.buf)
                end
            end,
            desc = "Enable treesitter (and install parser if not installed).",
        })
    end,
}
