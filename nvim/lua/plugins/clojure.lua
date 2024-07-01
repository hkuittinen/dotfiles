-- local clojure_iskeyword_group = vim.api.nvim_create_augroup("ClojureIsKeyword", { clear = true })
-- -- Define the autocmds to remove specific characters from iskeyword
-- vim.api.nvim_create_autocmd({ "BufWinEnter", "BufNewFile", "BufRead" }, {
--     pattern = { "*.clj", "*.edn" },
--     group = clojure_iskeyword_group,
--     callback = function()
--         vim.opt_local.iskeyword:remove(".")
--         vim.opt_local.iskeyword:remove("/")
--         vim.opt_local.iskeyword:remove("-")
--     end,
-- })

return {
    -- Interactive REPL development.
    {
        "Olical/conjure",
        ft = { "clojure" },
        dependencies = {
            {
                "PaterJason/cmp-conjure",
                config = function()
                    local cmp = require("cmp")
                    local config = cmp.get_config()
                    table.insert(config.sources, {
                        name = "buffer",
                        option = {
                            sources = {
                                { name = "conjure" },
                            },
                        },
                    })
                    cmp.setup(config)
                end,
            },
        },
        config = function(_, opts)
            require("conjure.main").main()
            require("conjure.mapping")["on-filetype"]()

            vim.api.nvim_create_autocmd("BufNewFile", {
                group = vim.api.nvim_create_augroup("conjure-log-disable-lsp", { clear = true }),
                pattern = { "conjure-log-*" },
                callback = function(event)
                    vim.diagnostic.enable(false, { bufnr = 0 })
                end,
                desc = "Conjure Log disable LSP diagnostics",
            })
        end,
        init = function()
            -- Set configuration options here
            -- vim.g["conjure#debug"] = true
            -- Disable the documentation mapping
            vim.g["conjure#mapping#doc_word"] = false
            -- Rebind it from K to <prefix>gk
            vim.g["conjure#mapping#doc_word"] = "gk"
            -- Reset it to the default unprefixed K (note the special table wrapped syntax)
            -- vim.g["conjure#mapping#doc_word"] = { "K" }
        end,
    },
    -- Automatically balance parentheses.
    -- {
    --     "gpanders/nvim-parinfer",
    --     ft = { "clojure" },
    --     config = function()
    --         vim.g.parinfer_force_balance = true
    --     end,
    -- },
}
