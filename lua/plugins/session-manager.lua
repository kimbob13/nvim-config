return {
  "Shatur/neovim-session-manager",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    autosave_last_session = false,
  },
  config = function(_, opts)
    require("session_manager").setup(opts)
  end,
}
