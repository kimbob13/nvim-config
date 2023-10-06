return {
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufReadPost",
    config = function()
      require("mini.indentscope").setup()
    end,
  }
}
