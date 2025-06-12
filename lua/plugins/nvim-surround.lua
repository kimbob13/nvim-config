require("util").lazy_file()

return {
  "kylechui/nvim-surround",
  version = "*",   -- Use for stability; omit to use `main` branch for the latest features
  event = "LazyFile",
  opts = {},
  config = function(_, opts)
    require("nvim-surround").setup(opts)
  end,
}
