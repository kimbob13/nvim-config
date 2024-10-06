local autocmd_group = vim.api.nvim_create_augroup("Formatter auto-commands", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.py" },
  desc = "Auto format Python files after saving",
  callback = function()
    local file_name = vim.api.nvim_buf_get_name(0)
    vim.cmd(":silent !black " .. file_name)
  end,
  group = autocmd_group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.js", "*.ts", "*.json" },
  desc = "Auto format JS/TS files after saving",
  callback = function()
    local file_name = vim.api.nvim_buf_get_name(0)
    vim.cmd(":silent !prettier --write " .. file_name)
  end,
  group = autocmd_group,
})
