-----------------------------------------------------------
---- barbecue and nvim-navic                              |
-----------------------------------------------------------
vim.opt.updatetime = 200

require("barbecue").setup({
  create_autocmd = false,
  attach_navic = false,
})

vim.api.nvim_create_autocmd({
  "WinResized", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})

local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-----------------------------------------------------------
---- lsp config                                           |
-----------------------------------------------------------
local optional_lsp = vim.tbl_keys(require("util.lsp_ft").optional)

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = {
    exclude = optional_lsp,
  },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.set_log_level("off")

-- clangd
lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--header-insertion=never",
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- pylsp
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {
            "W391", -- blank line at end of file
            "W503", -- line break before binary operator
            "E203", -- whitespace before :
            "E221", -- multiple spaces before operator
          },
          maxLineLength = 100,
        }
      }
    }
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- lua lsp
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telementry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- rust-analyaer
lspconfig.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      -- cargo = {
      --   target = "riscv32i-unknown-none-elf",
      -- },
      checkOnSave = {
        allTargets = false,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

-- setup optional lsp server
for _, server_name in pairs(optional_lsp) do
  lspconfig[server_name].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-----------------------------------------------------------
---- lsp config keymap                                    |
-----------------------------------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.server_capabilities.signatureHelpProvider then
      client.server_capabilities.signatureHelpProvider.triggerCharacters = {}
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- move to telescope
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
