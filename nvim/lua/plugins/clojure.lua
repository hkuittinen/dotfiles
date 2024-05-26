local clojure_iskeyword_group = vim.api.nvim_create_augroup("ClojureIsKeyword", { clear = true })
-- Define the autocmds to remove specific characters from iskeyword
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufNewFile", "BufRead" }, {
    pattern = { "*.clj", "*.edn" },
    group = clojure_iskeyword_group,
    callback = function()
        vim.opt_local.iskeyword:remove(".")
        vim.opt_local.iskeyword:remove("/")
        vim.opt_local.iskeyword:remove("-")
    end,
})

return {
    -- Interactive REPL development.
    "Olical/conjure",
    ft = { "clojure" },
    -- [Optional] cmp-conjure for cmp
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
    end,
    init = function()
        -- Set configuration options here
        -- vim.g["conjure#debug"] = true
    end,
}
