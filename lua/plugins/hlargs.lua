return {
  "m-demare/hlargs.nvim",
  event = "BufReadPost",
  ft = { "python" },
  config = function()
    require("hlargs").setup({
      color = "#fc9867",
      paint_arg_declarations = false,
    })
  end,
}
