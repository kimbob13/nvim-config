return {
  "m-demare/hlargs.nvim",
  ft = { "python", "ruby" },
  config = function()
    require("hlargs").setup({
      -- color = "#fc9867", -- monokai pro
      -- color = "#ea999c",  -- catppuccin-frappe (maroon)
      -- color = "#ee99a0",  -- catppuccin-macchiato (maroon)
      -- color = "#e0af68", -- tokyonight-storm
      color = "#ffc777", -- tokyonight-moon
      excluded_argnames = {
        declarations = {
          python = { "self", "cls" },
          lua = { "self" },
        },
      },
    })
  end,
}
