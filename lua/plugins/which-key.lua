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
      ["<leader>"] = {
        -- telescope
        f = {
          name = "+telescope-basic",
          f = { ":Telescope find_files<CR>", "Find files" },
          g = { ":Telescope grep_string<CR>", "Grep string" },
          b = { ":Telescope buffers<CR>", "Find buffers" },
          h = { ":Telescope help_tags<CR>", "Help tags" },
        },
        g = {
          name = "+telescope-git",
          c = { ":Telescope git_commits<CR>", "Git commits" },
          b = { ":Telescope git_branches<CR>", "Git branches" },
          s = { ":Telescope git_status<CR>", "Git status" },
          t = { ":Telescope git_stash<CR>", "Git stash" },
          d = { ":Telescope git_bcommits<CR>", "Git bcommits (current buffer commit diff)" },

          -- git-blame
          l = { ":GitBlameToggle<CR>", "Git blame" },
        },

        l = {
          name = "+telescope-lsp",
          r = { ":Telescope lsp_references<CR>", "LSP references" },
          i = { ":Telescope lsp_incoming_calls<CR>", "LSP incoming calls" },
          o = { ":Telescope lsp_outgoing_calls<CR>", "LSP outgoing calls" },
          s = { ":Telescope lsp_document_symbols<CR>", "LSP document symbols" },
          d = { ":Telescope diagnostics<CR>", "LSP diagnostics" },

        },

        -- leap.nvim
        s = { "<Plug>(leap-forward-to)", "leap.nvim: forward search" },
        S = { "<Plug>(leap-backward-to)", "leap.nvim: backward search" },

        -- session-manager
        m = {
          name = "+session-manager",
          l = { ":SessionManager load_session<CR>", "Load Session" },
          t = { ":SessionManager load_last_session<CR>", "Load Last Session" },
          s = { ":SessionManager save_current_session<CR>", "Save Current Session" },
        }
      },
      ["<leader>/"] = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        "Telescope: Live grep" },

      -- ctags
      ["<leader>]"] = { ':vsp <CR>:exec("tag ".expand("<cword>"))<CR>', "Ctags vertical split" },

      -- buffer
      ["<leader>b"] = {
        name = "+bufferline",
        d = { ":bp|bd #<CR>", "Close buffer" },
      },
      ["<C-h>"] = { ":bprevious<CR>", "Go to left buffer" },
      ["<C-l>"] = { ":bnext<CR>", "Go to right buffer" },

      -- symbols outline
      ["<F8>"] = { ":SymbolsOutline<CR>", "Symbols Outline", noremap = true },
    }

    wk.register(keymaps)
  end,
}
