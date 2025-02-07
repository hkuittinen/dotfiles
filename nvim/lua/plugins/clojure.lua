return {
    {
        "Olical/conjure",
        ft = { "clojure" },
        lazy = true,
        init = function()
            -- Set configuration options here
            -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
            -- This is VERY helpful when reporting an issue with the project
            -- vim.g["conjure#debug"] = true

            -- Disable the documentation mapping
            -- vim.g["conjure#mapping#doc_word"] = false

            -- Rebind it from K to <prefix>gk
            vim.g["conjure#mapping#doc_word"] = "gk"

            -- Reset it to the default unprefixed K (note the special table wrapped syntax)
            -- vim.g["conjure#mapping#doc_word"] = { "K" }
        end,

        -- Optional cmp-conjure integration
        dependencies = { "PaterJason/cmp-conjure" },
    },
    {
        "PaterJason/cmp-conjure",
        lazy = true,
        config = function()
            local cmp = require("cmp")
            local config = cmp.get_config()
            table.insert(config.sources, { name = "conjure" })
            return cmp.setup(config)
        end,
    },
}
