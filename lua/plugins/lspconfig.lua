return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup{}
        lspconfig.pyright.setup{}
        lspconfig.rust_analyzer.setup{}
    end,
}
