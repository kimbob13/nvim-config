return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufReadPost",
    opts = {
      enhanced_diff_hl = false,
    },
    config = function(_, opts)
      require("diffview").setup(opts)
    end,
  }
}
