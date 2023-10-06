local M = {
  "monkoose/matchparen.nvim",
  event = "BufReadPost",
  opts = {},
  config = function(_, opts)
    require("matchparen").setup(opts)
  end,
}

vim.g.loaded_matchparen = 1

return M
