local enabled_ft = {
  "c", "cpp", "python", "lua", "rust", -- essential
  "ruby", "javascript", "typescript", "vue",  -- hobby
}

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

    -- snippets
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",

    -- menu icons
    "onsails/lspkind.nvim",
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

local M = {
  nvim_lspconfig,
  nvim_cmp,
  barbecue,
  symbols_outline,
}

return M
