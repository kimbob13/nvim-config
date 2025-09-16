local autocmd_group = vim.api.nvim_create_augroup("Formatter auto-commands", { clear = true })
local formatter_config = {
  clang_format = {
    pattern = { "*.c", "*.h", "*.cc", "*.cpp", "*.hpp" },
    desc = "Auto format C/C++ files after saving",
    cmd = "clang-format -i",
  },
  black = {
    pattern = { "*.py" },
    desc = "Auto format Python files after saving",
    cmd = "black --line-length=120",
  },
  prettier = {
    pattern = { "*.js", "*.ts", "*.json" },
    desc = "Auto format JS/TS files after saving",
    cmd = "prettier --write",
  },
  rustfmt = {
    pattern = { "*.rs" },
    desc = "Auto format Rust files after saving",
    cmd = "rustfmt",
  },
}

for _, opts in pairs(formatter_config) do
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = opts.pattern,
    desc = opts.desc,
    callback = function()
      local file_name = vim.api.nvim_buf_get_name(0)
      vim.cmd(":silent !" .. opts.cmd .. " " .. file_name)
    end,
    group = autocmd_group,
  })
end
