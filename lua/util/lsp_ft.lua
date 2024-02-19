-- key: lsp server name in lspconfig.nvim
-- value: corresponding filetype in nvim
return {
  required = {
    clangd = { "c", "cpp" },
    pylsp = { "python" },
    lua_ls = { "lua" },
    rust_analyzer = { "rust" },
  },
  optional = {
    solargraph = { "ruby" },
    tsserver = { "javascript", "typescript" },
    volar = { "vue" },
  },
}
