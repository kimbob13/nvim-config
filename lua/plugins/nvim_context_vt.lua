require("util").lazy_file()

return {
  "haringsrob/nvim_context_vt",
  event = "LazyFile",
  opts = {
    disable_virtual_lines = true,
  },
  config = function(_, opts)
    require("nvim_context_vt").setup(opts)
  end,
}
