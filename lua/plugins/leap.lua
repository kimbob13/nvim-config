return {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat", keys = { "." } },
    config = function()
        require("leap").set_default_keymaps()
        vim.keymap.del("n", "s")
        vim.keymap.del("n", "S")
    end,
}
