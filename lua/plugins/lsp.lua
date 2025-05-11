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
  dependencies = {
    {
      "hasansujon786/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = { lsp = { auto_attach = true } },
    },
  },
  ft = enabled_ft,
  config = function()
    require("config.lsp")
    require("config.formatter")
  end,
}

return {
  mason,
  lspconfig,
}
