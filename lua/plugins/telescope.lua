return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  opts = {
    defaults = {
      borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
      }
    }
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("live_grep_args")
  end,
}
