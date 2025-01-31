require("cscope_maps").setup({
  cscope = {
    picker = "telescope",
    skip_picker_for_single_result = true,
    db_build_cmd = { args = { "-bqkR" } },
  },
})

-- convert cs command to Cscope
vim.cmd([[
  fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
  endfun
  call SetupCommandAlias("cs", "Cscope")
]])

vim.keymap.set("n", "<F5>", ":Cscope db build<CR>", { noremap = true, silent = true, })
