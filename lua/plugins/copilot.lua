require("util").lazy_file()

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "LazyFile",
  config = function ()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
