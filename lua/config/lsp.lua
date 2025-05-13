-----------------------------------------------------------
---- nvim-navic
-----------------------------------------------------------
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-----------------------------------------------------------
---- lsp config
-----------------------------------------------------------
vim.lsp.set_log_level("off")

-- setup optional lsp server
local lsp_ft = require("util.lsp_ft")
for server_name, server_config in pairs(lsp_ft) do
  vim.lsp.enable(server_name)

  server_config.opts.on_attach = on_attach
  vim.lsp.config(server_name, server_config.opts)
end

-----------------------------------------------------------
---- lsp config keymap
-----------------------------------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set(
  "n",
  "]d", -- goto previous diagnostic
  function()
    vim.diagnostic.jump({ count = -1, float = true })
  end
)
vim.keymap.set(
  "n",
  "]d", -- goto next diagnostic
  function()
    vim.diagnostic.jump({ count = 1, float = true })
  end
)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client.server_capabilities.signatureHelpProvider then
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

-- lsp diagnostic config
vim.diagnostic.config({ virtual_lines = { current_line = true } })
