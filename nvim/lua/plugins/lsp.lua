local servers = {
    lua_ls = {},
    tsserver = {},
}

local tools = {
    stylua = {},
    prettier = {},
    eslint_d = {},
}

return {
    -- Easily install and manage LSP servers, linters, formatters
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Ensure servers installed with Mason are set up with the necessary config
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = vim.tbl_keys(servers),
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = vim.tbl_keys(tools),
            })
        end,
    },
    -- Configs for the Nvim LSP client
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Useful status updates for LSP
            {
                "j-hui/fidget.nvim",
                opts = {},
            },
            -- Additional lua configuration, improves nvim stuff
            {
                "folke/neodev.nvim",
                config = function()
                    require("neodev").setup()
                end,
            },
        },
        config = function()
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
            })

            vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, opts)
                end,
            })

            local signs = { Error = "", Warn = "", Hint = "󰛩", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
    -- Formatters and linters
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local null_ls = require("null-ls") -- "null-ls" for historical reasons
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    -- Lua
                    null_ls.builtins.formatting.stylua,

                    -- JavaScript/TypeScript
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.eslint_d,
                },
                on_attach = function(client, bufnr)
                    -- Format on save
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })

            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
        end,
    },
}
