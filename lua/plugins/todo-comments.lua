return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function(_, opts)
    require("todo-comments").setup(opts)
  end,
}
