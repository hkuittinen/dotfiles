local servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        "${3rd}/luv/library",
                        unpack(vim.api.nvim_get_runtime_file("", true)),
                    },
                },
                completion = {
                    callSnippet = "Replace",
                },
                -- diagnostics = { disable = { 'missing-fields' } },
            },
        },
    },
    tsserver = {},
    eslint = {},
    svelte = {},
}

local tools = {
    stylua = {},
    prettierd = {},
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
            { "j-hui/fidget.nvim", opts = {} },
            -- Additional lua configuration, improves nvim stuff
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            local _border = "single"
            -- Add the border on hover and on signature help popup window
            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border }),
            }
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            settings = servers[server_name],
                            filetypes = (servers[server_name] or {}).filetypes,
                            handlers = handlers,
                        })
                    end,
                },
            })

            vim.diagnostic.config({
                virtual_text = false,
                float = {
                    width = 80,
                    border = _border,
                },
            })
            vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
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
            {
                "nvim-lua/plenary.nvim",
            },
        },
        config = function()
            local null_ls = require("null-ls") -- "null-ls" for historical reasons
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    -- Lua
                    null_ls.builtins.formatting.stylua,

                    -- JavaScript/TypeScript
                    null_ls.builtins.formatting.prettierd.with({
                        extra_filetypes = { "svelte" },
                    }),
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
