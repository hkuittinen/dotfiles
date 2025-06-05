return {
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
    -- Main LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- Status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },
            -- Extra capabilities provided by blink.cmp.
            "saghen/blink.cmp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("fr", require("telescope.builtin").lsp_references, "[F]find [R]eferences")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                end,
            })

            -- Diagnostic Config
            vim.diagnostic.config({
                severity_sort = true,
                virtual_text = false,
                float = { source = true, width = 80 },
                underline = { severity = vim.diagnostic.severity.ERROR },
            })
            vim.keymap.set("n", "<space>i", vim.diagnostic.open_float)

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            --  Available keys for servers are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            local servers = {
                lua_ls = {
                    -- cmd = { ... },
                    -- filetypes = { ... },
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- Toggle below to ignore Lua_LS's noisy `missing-fields` warnings.
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                vue_ls= {}, -- Vue 3
                ts_ls = {
                    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                                languages = { "vue" },
                            },
                        },
                    },
                },
            }

            local tools = {
                "stylua", -- Lua formatter
                "prettierd", -- Javascript formatter
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, tools)
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                ensure_installed = {}, -- Explicitly set to an empty table (populated via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    -- Formatters
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>F",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = true,
            notify_no_formatters = true,
            -- Uncomment to format on save. I prefer <leader>F.
            -- format_on_save = {
            --     lsp_format = "fallback",
            --     timeout_ms = 500,
            -- },
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd" },
                json = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                vue = { "prettierd" },
                css = { "prettierd" },
                html = { "prettierd" },
                yaml = { "prettierd" },
            },
        },
    },
}
