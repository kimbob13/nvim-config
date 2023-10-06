require("ibl").setup({
  indent = { char = "│" },
  exclude = {
    filetypes = {
      "lspinfo",
      "checkhealth",
      "help",
      "man",
      "gitcommit",
      "TelescopePrompt",
      "TelescopeResults",
      "dashboard",
    },
  },
})

local hooks = require "ibl.hooks"
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
