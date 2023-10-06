return {
  "dhananjaylatkar/cscope_maps.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "c", "cpp" },
  config = function()
    require("config.cscope_maps")
  end,
}
