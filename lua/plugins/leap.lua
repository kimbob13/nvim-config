require("util").lazy_file()

return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat", keys = { "." } },
  event = "LazyFile",
  config = function()
    require("leap").set_default_keymaps()
    vim.keymap.del({ "n", "v" }, "s")
    vim.keymap.del({ "n", "v" }, "S")
  end,
}
