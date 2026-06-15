return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "quarto", "rmd", "Avante", "codecompanion" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    preview = {
      icon_provider = "devicons",
    },
  },
  config = function(_, opts)
    require("markview").setup(opts)
  end,
}
