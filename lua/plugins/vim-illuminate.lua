return {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = {
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
    end,
}
