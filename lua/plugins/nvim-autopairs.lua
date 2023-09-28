return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    map_cr = true,
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}
