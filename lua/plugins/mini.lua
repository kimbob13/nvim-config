require("util").lazy_file()

return {
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "LazyFile",
    config = function()
      require("mini.indentscope").setup()
    end,
  }
}
