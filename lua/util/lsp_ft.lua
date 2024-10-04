-- key: lsp server name in nvim-lspconfig
-- value: corresponding filetype in nvim
return {
  required = {
    clangd = { "c", "cpp" },
    pylsp = { "python" },
    lua_ls = { "lua" },
    rust_analyzer = { "rust" },
    ts_ls = { "javascript", "typescript" },
    volar = { "vue" },
  },
  optional = {
    eslint = { "javascript", "typescript" },
    solargraph = { "ruby" },
    jsonls = { "json", "jsonc" },
    yamlls = { "yaml", "yaml.docker-compose" },
    dockerls = { "dockerfile" },
  },
}
