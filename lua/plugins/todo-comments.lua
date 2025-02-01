return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function(_, opts)
    require("todo-comments").setup(opts)
  end,
}
