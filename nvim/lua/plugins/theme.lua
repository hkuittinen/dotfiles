function NumberedTabs()
    local s = ""
    for i = 1, vim.fn.tabpagenr("$") do
        local highlight = (i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
        s = s .. highlight .. " " .. i .. " "
    end
    return s
end
vim.o.tabline = "%!v:lua.NumberedTabs()"

require("lualine").setup({
    options = {
        icons_enabled = false,
        component_separators = "|",
        section_separators = "",
    },
})

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
