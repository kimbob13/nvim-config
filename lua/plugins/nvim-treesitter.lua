local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local nvim_treesitter = require("nvim-treesitter")
      nvim_treesitter.setup({
        auto_install = true,
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query",         -- (these five parsers should always be installed)
          "python", "rust", "diff",
        },
      })
      nvim_treesitter.install()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end,
  },
}

-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
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

-- keymaps
vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end)

-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ "n", "x", "o" }, "]o", function()
  move.goto_next_start({"@loop.inner", "@loop.outer"}, "textobjects")
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

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
vim.keymap.set({ "n", "x", "o" }, "]d", function()
  require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[d", function()
  require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end)

return M


-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--     event = "VeryLazy",
--     dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
--     opts = {
--       -- A list of parser names, or "all"
--       ensure_installed = {
--         "c", "lua", "vim", "vimdoc", "query",         -- (these five parsers should always be installed)
--         "python", "rust", "diff",
--       },
-- 
--       -- Install parsers synchronously (only applied to `ensure_installed`)
--       sync_install = false,
-- 
--       -- Automatically install missing parsers when entering buffer
--       -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--       auto_install = true,
-- 
--       highlight = {
--         enable = true,
-- 
--         -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--         -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--         -- the name of the parser)
--         -- list of language that will be disabled
--         -- disable = { "c" },
-- 
--         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--         -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--         -- Using this option may slow down your editor, and you may see some duplicate highlights.
--         -- Instead of true it can also be a list of languages
--         additional_vim_regex_highlighting = false,
--       },
-- 
--       incremental_selection = {
--         enable = true,
--         keymaps = {
--           init_selection = "<CR>",
--           node_incremental = "<CR>",
--           scope_incremental = "<TAB>",
--           node_decremental = "<S-TAB>",
--         },
--       },
-- 
--       ---- treesitter-textobjects configs
--       textobjects = {
--         select = {
--           enable = true,
--           -- Automatically jump forward to textobj, similar to targets.vim
--           lookahead = true,
--           keymaps = {
--             -- You can use the capture groups defined in textobjects.scm
--             ["af"] = "@function.outer",
--             ["if"] = "@function.inner",
--             ["ac"] = "@class.outer",
--             ["ic"] = "@class.inner",
--             ["as"] = {
--               query = "@scope",
--               query_group = "locals",
--               desc = "Select language scope",
--             },
--           },
--         },
--         move = {
--           enable = true,
--           set_jumps = true,
--           goto_next_start = {
--             ["]m"] = "@function.outer",
--             ["]]"] = "@class.outer",
--             ["]o"] = "@loop.*",
--             ["]s"] = {
--               query = "@scope",
--               query_group = "locals",
--               desc = "Next scope",
--             },
--             ["]p"] = "@parameter.inner",
--           },
--           goto_next_end = {
--             ["]M"] = "@function.outer",
--             ["]["] = "@class.outer",
--           },
--           goto_previous_start = {
--             ["[m"] = "@function.outer",
--             ["[["] = "@class.outer",
--             ["[s"] = {
--               query = "@scope",
--               query_group = "locals",
--               desc = "Previous scope",
--             },
--             ["[p"] = "@parameter.inner",
--           },
--           goto_previous_end = {
--             ["[M"] = "@function.outer",
--             ["[]"] = "@class.outer",
--           },
--         },
--         swap = {
--           enable = true,
--           swap_next = { ["<leader>xp"] = "@parameter.inner" },
--           swap_previous = { ["<leader>xP"] = "@parameter.inner" },
--         },
--         lsp_interop = {
--           enable = true,
--           border = "none",
--           floating_preview_opts = {},
--           peek_definition_code = {
--             ["<leader>df"] = "@function.outer",
--             ["<leader>dF"] = "@class.outer",
--           },
--         },
--       },
-- 
--     },
--     config = function(_, opts)
--       require("nvim-treesitter.configs").setup(opts)
--       require("nvim-treesitter.install").prefer_git = true
--     end,
--   },
--   {
--     "nvim-treesitter/nvim-treesitter-context",
--     event = { "BufReadPost", "BufNewFile" },
--     opts = {
--       enable = true,
--     },
--     config = function(_, opts)
--       require("treesitter-context").setup(opts)
--     end,
--   },
-- }
