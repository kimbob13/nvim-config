return {
    "simrat39/symbols-outline.nvim",
    keys = {
        {
            "<F8>",
            "<CMD>SymbolsOutline<CR>",
            mode = "n",
            noremap = true,
            desc = "Symbols Outline",
        },
    },
    config = function()
        require("symbols-outline").setup()
    end,
}
