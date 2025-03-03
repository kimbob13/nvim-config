local copilot = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  config = function ()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}

local copilot_cmp = {
  "zbirenbaum/copilot-cmp",
  config = function ()
    require("copilot_cmp").setup()
  end,
}

return { copilot, copilot_cmp }
