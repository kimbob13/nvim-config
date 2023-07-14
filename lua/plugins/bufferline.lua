return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        vim.keymap.set(
            "n", "<C-h>", ":bprevious<Enter>",
            {
                noremap = true,
                desc = "bufferline: left buffer",
            }
        )
        vim.keymap.set(
            "n", "<C-l>", ":bnext<Enter>",
            {
                noremap = true,
                desc = "bufferline: right buffer",
            }
        )
        vim.keymap.set(
            "n", "<leader>bd", ":bp|bd #<Enter>",
            {
                noremap = true,
                desc = "bufferline: close buffer",
            }
        )
    end,
    opts = {
        options = {
            themable = true,
            separator_style = "slant",
        },
    },
}
