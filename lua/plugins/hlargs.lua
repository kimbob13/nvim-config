return {
  "m-demare/hlargs.nvim",
  event = "BufReadPost",
  ft = { "python" },
  config = function()
    require("hlargs").setup({
      paint_arg_declarations = false,
    })
  end,
}
