require("util").lazy_file()

return {
  "RRethy/vim-illuminate",
  event = "LazyFile",
  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
