require("util").lazy_file()

-- keymaps for nvim-treesitter-textobjects
-- You can use the capture groups defined in `textobjects.scm`

-- select
vim.keymap.set({ "x", "o" }, "am", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)

-- swap
vim.keymap.set("n", "<leader>p", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>P", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end)

-- move
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ "n", "x", "o" }, "]o", function()
  require("nvim-treesitter-textobjects.move").goto_next_start({"@loop.inner", "@loop.outer"}, "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set({ "n", "x", "o" }, "]s", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
vim.keymap.set({ "n", "x", "o" }, "]z", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

vim.keymap.set({ "n", "x", "o" }, "]M", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[M", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      local available = treesitter.get_available()
      local installing = {}

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("vim-treesitter-start", { clear = true }),
        desc = "Install missing parsers and enable Treesitter highlighting",
        callback = function(args)
          -- Filetypes and parser names can differ (e.g. sh -> bash, typescriptreact -> tsx).
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang or lang == "" then
            return
          end

          -- Bundled parsers do not count as installed by nvim-treesitter.
          if
            not vim.list_contains(available, lang)
            or vim.list_contains(treesitter.get_installed("parsers"), lang)
          then
            pcall(vim.treesitter.start, args.buf, lang)
            return
          end

          if installing[lang] then
            return
          end

          installing[lang] = true
          -- Query-only remnants otherwise make the installer skip a missing parser.
          local force = vim.list_contains(treesitter.get_installed("queries"), lang)
          -- Keep editing while the parser downloads and compiles.
          treesitter.install({ lang }, { force = force }):await(vim.schedule_wrap(function(err, success)
            installing[lang] = nil
            if err or success == false then
              vim.notify("Treesitter parser installation failed for " .. lang .. "; see :TSLog", vim.log.levels.WARN)
              return
            end

            -- Other buffers may have opened or changed filetype during installation.
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if
                vim.api.nvim_buf_is_loaded(buf)
                and vim.treesitter.language.get_lang(vim.bo[buf].filetype) == lang
              then
                pcall(vim.treesitter.start, buf, lang)
              end
            end
          end))
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = {
      enable = true,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end,
  },
}
