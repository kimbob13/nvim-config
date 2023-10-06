local nvim_lspconfig = {
  "neovim/nvim-lspconfig",
}

local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
  },
  config = function()
    require("config.lsp")
  end,
}


local M = { nvim_lspconfig, nvim_cmp }

return M
