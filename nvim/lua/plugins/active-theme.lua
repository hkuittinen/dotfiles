function NumberedTabs()
    local s = ""
    for i = 1, vim.fn.tabpagenr("$") do
        local highlight = (i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
        s = s .. highlight .. " " .. i .. " "
    end
    return s
end
vim.o.tabline = "%!v:lua.NumberedTabs()"

return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                icons_enabled = false,
                component_separators = "|",
                section_separators = "",
            },
        },
    },
    -- Kanagawa
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
            })
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
}
