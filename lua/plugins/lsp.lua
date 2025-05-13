local lsp_ft = require("util.lsp_ft")
local enabled_ft = {}
for _, server_config in pairs(lsp_ft) do
  if server_config.ft then
    for _, ft in ipairs(server_config.ft) do
      if not vim.tbl_contains(enabled_ft, ft) then
        table.insert(enabled_ft, ft)
      end
    end
  end
end

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
