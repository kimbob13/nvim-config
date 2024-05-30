local monokai_pro = {
  "loctvl842/monokai-pro.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = false,
    devicons = true,
    styles = {
      comment = { italic = true },
      keyword = { italic = true },             -- any other keyword
      type = { italic = false },                -- (preferred) int, long, char, etc
      storageclass = { italic = false },        -- static, register, volatile, etc
      structure = { italic = false },           -- struct, union, enum, etc
      parameter = { italic = false },           -- parameter pass in function
      annotation = { italic = false },
      tag_attribute = { italic = false },       -- attribute of tag in reactjs
    },
    filter = "pro",                             -- classic | octagon | pro | machine | ristretto | spectrum
    background_clear = {
      "notify",
    },
    plugins = {
      bufferline = {
        underline_selected = true,
      },
    },
  },
  config = function(_, opts)
    require("monokai-pro").setup(opts)
  end,
}

local tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = { italic = false },
      variables = { italic = false },
    },
  },
}

local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "frappe",
    integrations = {
      telescope = {
        enabled = true,
        style = "nvchad",
      }
    }
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
  end,
}

local onedark = {
  "navarasu/onedark.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    style = "dark",
    code_style = {
      comments = "italic",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none"
    },
  },
  config = function(_, opts)
    require("onedark").setup(opts)
  end,
}

local M = { monokai_pro, tokyonight, catppuccin, onedark }

return M
