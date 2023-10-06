local enabled_ft = { "c", "cpp", "python", "lua", "rust", "ruby" }

local nvim_lspconfig = {
  "neovim/nvim-lspconfig",
  ft = enabled_ft,
}

local barbecue = {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  ft = enabled_ft,
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
}

local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  ft = enabled_ft,
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

local symbols_outline = {
  "simrat39/symbols-outline.nvim",
  ft = enabled_ft,
  config = function()
    require("symbols-outline").setup()
  end,
}

local M = { nvim_lspconfig, barbecue, nvim_cmp, symbols_outline }

return M
