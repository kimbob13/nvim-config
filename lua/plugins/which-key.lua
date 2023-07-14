return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")
        local keymaps = {
            -- telescope
            ["<leader>"] = {
                f = {
                    name = "+telescope-basic",
                    f = { ":Telescope find_files<CR>", "Find files" },
                    b = { ":Telescope buffers<CR>", "Find buffers" },
                    h = { ":Telescope help_tags<CR>", "Help tags" },
                },
                g = {
                    name = "+telescope-git",
                    c = { ":Telescope git_commits<CR>", "Git commits" },
                    b = { ":Telescope git_branches<CR>", "Git branches" },
                    s = { ":Telescope git_status<CR>", "Git status" },
                }
            },
            ["<leader>/"] = { ":Telescope live_grep<CR>", "Telescope: Live grep" },

            -- ctags
            ["<leader>]"] = { ':vsp <CR>:exec("tag ".expand("<cword>"))<CR>', "Ctags vertical split" },

            -- buffer
            ["<leader>b"] = {
                name = "+bufferline",
                d = { ":bp|bd #<CR>", "Close buffer" },
            },
            ["<C-h>"] = { ":bprevious<CR>", "Go to left buffer" },
            ["<C-l>"] = { ":bnext<CR>", "Go to right buffer" },
        }

        wk.register(keymaps)
    end,
}
