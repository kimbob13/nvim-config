return {
  "bounceme/poppy.vim",
  init = function()
    local Poppy = vim.api.nvim_create_augroup("Poppy", {})
    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "*",
      command = "call PoppyInit()",
      group=Poppy,
    })

    vim.g.poppy = 1
    vim.cmd(
      "command! PoppyToggle :call clearmatches() | " ..
      "let g:poppy = -get(g:, 'poppy', -1) | " ..
      "exe 'au! Poppy CursorMoved *' . (g:poppy > 0 ? ' call PoppyInit()' : '')"
    )

    vim.api.nvim_set_hl(0, "PoppyLevel1", {bg = "#F0961E", fg = "#000000", bold = true})
    vim.api.nvim_set_hl(0, "PoppyLevel2", {bg = "#3296F0", fg = "#000000", bold = true})
    vim.api.nvim_set_hl(0, "PoppyLevel3", {bg = "#96F032", fg = "#000000", bold = true})
    vim.api.nvim_set_hl(0, "PoppyLevel4", {bg = "#E650DC", fg = "#000000", bold = true})
    vim.api.nvim_set_hl(0, "PoppyLevel5", {bg = "#F1FF32", fg = "#000000", bold = true})
    vim.api.nvim_set_hl(0, "PoppyLevel6", {bg = "#FF4032", fg = "#000000", bold = true})

    vim.g.poppyhigh = {
      "PoppyLevel1", "PoppyLevel2", "PoppyLevel3",
      "PoppyLevel4", "PoppyLevel5", "PoppyLevel6"
    }
  end,
}
