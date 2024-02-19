local function has_words_before()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_nvim_lua = {
  "hrsh7th/cmp-nvim-lua",
  event = "BufReadPost",
  dependencies = { "hrsh7th/nvim-cmp" },
}

local cmp_buffer = {
  "hrsh7th/cmp-buffer",
  event = "BufReadPost",
  dependencies = { "hrsh7th/nvim-cmp" },
}

local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  event  = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- snippets
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",

    -- menu icons
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local snippy = require("snippy")

    cmp.setup({
      snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),         -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
      }),
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbolx = "[Latex]",
          })
        }),
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })

    -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      })
    })

    -----------------------------------------------------------
    ---- nvim-autopairs with nvim-cmp                         |
    -----------------------------------------------------------
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )
  end,
}

return { nvim_cmp, cmp_buffer, cmp_nvim_lua }
