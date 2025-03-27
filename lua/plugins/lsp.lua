local lsp_ft = require("util.lsp_ft")
local enabled_ft = vim.iter(
  vim.tbl_values(
    vim.tbl_deep_extend("error", lsp_ft.custom_opt, lsp_ft.default_opt)
  )
):flatten():totable()

local mason = {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
}

local lspconfig = {
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

local cmp_nvim_lsp = {
  "hrsh7th/cmp-nvim-lsp",
  ft = enabled_ft,
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    require("config.lsp")
  end,
}

local outline_nvim = {
  "hedyhli/outline.nvim",
  ft = enabled_ft,
  config = function()
    require("outline").setup()
  end,
}

return {
  mason,
  lspconfig,
  cmp_nvim_lsp,
  barbecue,
  outline_nvim,
}
