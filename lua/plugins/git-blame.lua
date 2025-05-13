return {
  "f-person/git-blame.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("gitblame").setup({
      enabled = false,
      highlight_group = "Question",
    })
  end,
}
