return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("config.rainbow-delimiters")
  end,
}
