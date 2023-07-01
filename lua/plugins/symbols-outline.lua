return {
    "simrat39/symbols-outline.nvim",
    keys = {
        {
            "<F8>",
            "<CMD>SymbolsOutline<CR>",
            mode = "n",
            noremap = true,
        },
    },
    config = function()
        require("symbols-outline").setup()
    end,
}
