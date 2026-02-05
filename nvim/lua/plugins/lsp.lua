return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts = {
                    ensure_installed = {
                        -- LSP
                        "lua_ls",
                        "vtsls",
                        "gopls",
                        "templ",
                        -- Tools
                        "stylua",
                        "eslint",
                        "prettierd",
                    },
                },
            },
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({})
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
                    end
                    local fzfLua = require("fzf-lua")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                    map("<leader>i", vim.diagnostic.open_float, "Open Diagnostic Float")
                    map("<leader>ca", fzfLua.lsp_code_actions, "Code Actions")
                    map("<leader>fr", fzfLua.lsp_references, "Find references")
                    map("<leader>fd", fzfLua.lsp_document_diagnostics, "Find document diagnostic")
                    map("<leader>fD", fzfLua.lsp_workspace_diagnostics, "Find workspace diagnostic")
                    map("gd", fzfLua.lsp_definitions, "Goto Definition")
                    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
                    map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename all references")

                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    if client:supports_method("textDocument/completion") then
                        vim.cmd([[set completeopt+=menuone,noselect,popup]])

                        -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                        local chars = {}
                        for i = 32, 126 do
                            table.insert(chars, string.char(i))
                        end
                        client.server_capabilities.completionProvider.triggerCharacters = chars

                        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                        vim.keymap.set("i", "<C-.>", function()
                            vim.lsp.completion.get()
                        end)
                    end
                end,
            })
        end,
    },
    -- Lua LSP for Neovim config, runtime and plugins,
    -- used for completion, annotations and signatures of Neovim apis
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    ----------------------------------------------------------------------------
    -- Formatters
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format({
                        async = true,
                        -- lsp_format = "fallback",
                    })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = true,
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
                yaml = { "prettierd" },
                json = { "prettierd" },
                go = { "goimports", "gofmt" },
                templ = { "templ" },
            },
        },
    },
}
