require("util").lazy_file()

return {
  "f-person/git-blame.nvim",
  event = "LazyFile",
  config = function()
    require("gitblame").setup({
      enabled = false,
      highlight_group = "Question",
    })
  end,
}
