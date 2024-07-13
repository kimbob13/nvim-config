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
      {
        mode = { "n" },
        { "<leader>f", group = "telescope" },

        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      },
      {
        mode = { "n" },
        { "<leader>g", group = "git" },

        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
        { "<leader>gt", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },
        {
          "<leader>gd",
          "<cmd>Telescope git_bcommits<cr>",
          desc = "Git Bcommits (current buffer commit diff)"
        },
        { "<leader>gl", "<cmd>GitBlameToggle<cr>", desc = "Git Blame" },
      },
      {
        mode = { "n" },
        { "<leader>l", group = "lsp" },

        { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
        { "<leader>li", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "LSP Incoming Calls" },
        { "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "LSP Outgoing Calls" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
        { "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "LSP Diagnostics" },
      },
      {
        -- leap.nvim
        mode = { "n" },
        { "<leader>s", "<Plug>(leap-forward-to)", desc = "leap.nvim: forward search" },
        { "<leader>S", "<Plug>(leap-backward-to)", desc = "leap.nvim: backward search" },
      },
      {
        mode = { "n" },
        { "<leader>m", group = "session manager" },

        { "<leader>ml", "<cmd>SessionManager load_session<cr>", desc = "Load Session" },
        { "<leader>mt", "<cmd>SessionManager load_last_session<cr>", desc = "Load Last Session" },
        { "<leader>ms", "<cmd>SessionManager save_current_session<cr>", desc = "Save Current Session" },
      },
      {
        -- telescope live grep
        "<leader>/",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
        desc = "Live Grep",
        mode = { "n" },
      },
      {
        -- ctags
        "<leader>]",
        ':vsp <CR>:exec("tag ".expand("<cword>"))<CR>',
        desc = "Ctags Vertical Split",
        mode = { "n" },
      },
      {
        -- buffer
        mode = { "n" },
        { "<leader>bd", "<cmd>bp|bd #<cr>", desc = "Close Buffer" },
        { "<C-h>", "<cmd>bprevious<cr>", desc = "Go to Left Buffer" },
        { "<C-l>", "<cmd>bnext<cr>", desc = "Go to Right Buffer" },
      },
      { "<F8>", "<cmd>Outline<cr>", desc = "Outline.nvim", mode = { "n" }, noremap = true },
    }

    wk.add(keymaps)
  end,
}
