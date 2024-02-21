local lsp_ft = require("util.lsp_ft")
local enabled_ft = vim.tbl_flatten(
  vim.tbl_values(
    vim.tbl_deep_extend("error", lsp_ft.required, lsp_ft.optional)
  )
)

local mason = {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  ft = enabled_ft,
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
  nvim_lspconfig,
  cmp_nvim_lsp,
  barbecue,
  outline_nvim,
}
