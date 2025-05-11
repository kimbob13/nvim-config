return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    presets = {
      bottom_search = true,               -- use a classic bottom cmdline for search
      command_palette = false,            -- position the cmdline and popupmenu together
      long_message_to_split = true,       -- long messages will be sent to a split
      inc_rename = false,                 -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,             -- add a border to hover docs and signature help
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    routes = {
      {
        view = "mini",
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
      },
      {
        view = "mini",
        filter = {
          any = {
            { event = "msg_showmode", find = "^recording" },
            { event = "msg_showcmd",  find = "[%d]" },
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)
  end,
}
