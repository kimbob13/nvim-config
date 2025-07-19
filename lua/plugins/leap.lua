require("util").lazy_file()

return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat", keys = { "." } },
  event = "LazyFile",
  config = function()
    require("leap").set_default_mappings()
    vim.keymap.del({ "n", "x", "o" }, "s")
    vim.keymap.del({ "n" }, "S")
  end,
}
