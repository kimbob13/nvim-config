return {
  "Shatur/neovim-session-manager",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function(_, opts)
    require("session_manager").setup(opts)
  end,
}
