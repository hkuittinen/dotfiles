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
    -- Dotnet
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {},
    },
    -- Main LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        cmd = { "Mason" },
        dependencies = {
            {
                "mason-org/mason.nvim",
                build = ":MasonUpdate",
                opts = {
                    registries = {
                        "github:mason-org/mason-registry",
                        "github:Crashdummyy/mason-registry", -- Roslyn (C# LSP)
                    },
                },
            },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} }, -- Status updates for LSP
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
                callback = function(event)
                    ----------------------------------
                    -- Load key mappings
                    ----------------------------------
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

                    ----------------------------------
                    -- Add highlights
                    ----------------------------------
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    local methods = vim.lsp.protocol.Methods
                    if client and client:supports_method(methods.textDocument_documentHighlight) then
                        vim.o.updatetime = 2000
                        local custom_higlight_name = "custom-lsp/highlight"
                        local cursor_higlights_group = vim.api.nvim_create_augroup(custom_higlight_name, { clear = false })

                        vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
                            buffer = event.buf,
                            group = cursor_higlights_group,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                            buffer = event.buf,
                            group = cursor_higlights_group,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("custom-lsp/detach", { clear = true }),
                            callback = function(detach_event)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({
                                    group = custom_higlight_name,
                                    buffer = detach_event.buf,
                                })
                            end,
                        })
                    end

                    ----------------------------------
                    -- inlay_hint
                    ----------------------------------
                    if client and client:supports_method(methods.textDocument_inlayHint) then
                        vim.keymap.set("n", "<leader>uh", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, { desc = "Toggle inlay hints", buffer = event.buf })
                    end
                end,
            })

            ----------------------------------
            -- Server configuration
            ----------------------------------
            -- vim.lsp.config("*", {
            --     capabilities = vim.lsp.protocol.make_client_capabilities(),
            -- })

            local servers = {
                "lua_ls",
                "vtsls",
                "vue_ls",
                "roslyn",
            }
            local tools = {
                "prettierd",
                "eslint_d",
                "stylua",
            }
            local ensure_installed = {}
            vim.list_extend(ensure_installed, servers)
            vim.list_extend(ensure_installed, tools)

            require("mason-lspconfig").setup({
                automatic_enable = true,
                ensure_installed = {},
            })

            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
            })

            vim.lsp.config("vtsls", {
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                settings = {
                    vtsls = { tsserver = { globalPlugins = {} } },
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "literals" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                },
                before_init = function(_, config)
                    table.insert(config.settings.vtsls.tsserver.globalPlugins, {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    })
                end,
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })

            ----------------------------------
            -- Diagnostics
            ----------------------------------
            vim.diagnostic.config({
                -- underline = true,
                virtual_text = false,
                update_in_insert = false,
                document_highlight = {
                    enabled = true,
                },
                codelens = {
                    enabled = false,
                },
                severity_sort = true,
                float = { source = true, width = 80 },
            })
            vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float)
        end,
    },
    ----------------------------------
    -- Formatters
    ----------------------------------
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
