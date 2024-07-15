return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim.keymap.set("n", "<leader>h", function()
            harpoon:list():add()
        end)

        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end)
        vim.keymap.set("n", "<leader>5", function()
            harpoon:list():select(5)
        end)
        vim.keymap.set("n", "<leader>6", function()
            harpoon:list():select(6)
        end)

        vim.keymap.set("n", "<leader>p", function()
            harpoon:list():prev()
        end)
        vim.keymap.set("n", "<leader>n", function()
            harpoon:list():next()
        end)
    end,
}
