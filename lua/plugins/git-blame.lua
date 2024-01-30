return {
  "f-person/git-blame.nvim",
  event = "BufReadPost",
  config = function()
    require("gitblame").setup({
      enabled = false,
      highlight_group = "Question",
    })
  end,
}
