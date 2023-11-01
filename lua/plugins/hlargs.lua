return {
  "m-demare/hlargs.nvim",
  ft = { "python", "ruby" },
  config = function()
    require("hlargs").setup({
      color = "#fc9867",
      excluded_argnames = {
        declarations = {
          python = { "self", "cls" },
          lua = { "self" },
        },
      },
    })
  end,
}
