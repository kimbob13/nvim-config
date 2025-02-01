return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  keys = {
    {
      "<C-n>",
      "<CMD>Neotree toggle=true<CR>",
      mode = "n",
      noremap = true,
      desc = "Neo Tree"
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    close_if_last_window = false,
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    default_component_configs = {
      indent = {
        with_expander = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          unstaged = "󰄱",
          staged = "󰱒",
        },
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
