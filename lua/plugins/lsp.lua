local mason = {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
}

local lspconfig = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
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
  config = function()
    require("config.lsp")
    require("config.formatter")
  end,
}

return {
  mason,
  lspconfig,
}
