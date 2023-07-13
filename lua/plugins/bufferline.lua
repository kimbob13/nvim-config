return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        vim.keymap.set('n', '<C-h>', ':bprevious<Enter>', { noremap = true })
        vim.keymap.set('n', '<C-l>', ':bnext<Enter>', { noremap = true })
    end,
    opts = {
        options = {
            themable = true,
            separator_style = "slant",
        },
    },
}
