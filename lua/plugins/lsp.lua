return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup {}
        -- lspconfig.pyright.setup {}
        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = {"W391"},
                            maxLineLength = 100,
                        }
                    }
                }
            }
        }
        lspconfig.rust_analyzer.setup {}
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telementry = {
                        enable = false,
                    },
                },
            },
        }
    end,
}
