-- key: lsp server name in nvim-lspconfig
-- value: corresponding filetype in nvim
return {
  custom_opt = {
    clangd = { "c", "cpp" },
    pylsp = { "python" },
    lua_ls = { "lua" },
    rust_analyzer = { "rust" },
  },
  default_opt = {
    ts_ls = { "javascript", "typescript" },
    volar = { "vue" },
    eslint = { "javascript", "typescript" },
    solargraph = { "ruby" },
    jsonls = { "json", "jsonc" },
    yamlls = { "yaml", "yaml.docker-compose" },
    dockerls = { "dockerfile" },
  },
}
