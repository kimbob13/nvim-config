vim.g.loaded_matchparen = 1

local M = {
  "monkoose/matchparen.nvim",
  event = "BufReadPost",
  opts = {
    on_startup = true,
    hl_group = "MatchParen",
    augroup_name = "matchparen",
    debounce_time = 100,
  },
  config = function(_, opts)
    require("matchparen").setup(opts)
  end,
}

return M
