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
            },
        },
    },
    clojure_lsp = {},
    html = {},
    eslint = {},
    svelte = {},
    marksman = {},
    volar = {}, -- Vue 3
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
    denols = {},
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
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local lspconfig = require("lspconfig")
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

                        if server_name == "ts_ls" then
                            server.root_dir = lspconfig.util.root_pattern("package.json")
                        elseif server_name == "denols" then
                            server.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
                        end

                        lspconfig[server_name].setup(server)
                    end,
                },
            })

            vim.diagnostic.config({
                severity_sort = true,
                virtual_text = false,
                float = {
                    source = true,
                    width = 80,
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
                    map("fr", require("telescope.builtin").lsp_references, "[F]find [R]eferences")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")
                end,
            })

            -- vim.diagnostic.config({
            --     signs = {
            --         text = {
            --             [vim.diagnostic.severity.INFO] = "󰛩",
            --             [vim.diagnostic.severity.INFO] = "",
            --             [vim.diagnostic.severity.WARN] = "",
            --             [vim.diagnostic.severity.ERROR] = "",
            --         },
            --     },
            -- })
        end,
    },
    -- Formatters
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                -- format_on_save = {
                --     timeout_ms = 500,
                --     lsp_fallback = false,
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
                    clojure = { "cljfmt" },
                },
            })
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = true, lsp_format = "fallback", range = range })
            end, { range = true })
            vim.keymap.set("n", "<leader>F", "<cmd>Format<CR>")
        end,
    },
}
