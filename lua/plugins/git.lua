return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    opts = {
      enhanced_diff_hl = false,
    },
    config = function(_, opts)
      require("diffview").setup(opts)
    end,
  }
}
