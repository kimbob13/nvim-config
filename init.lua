-----------------------------------------------------------
---- set options                                          |
-----------------------------------------------------------
local set = vim.opt

-- Tab size
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.smartindent = true

set.mouse = "a"
set.inccommand = ""
set.completeopt = { "menu", "menuone", "noselect" }

set.number = true
set.relativenumber = true
set.cursorline = true
set.signcolumn = "yes:1"
set.title = true
set.termguicolors = true
set.laststatus = 3

set.swapfile = false
set.backup = false
set.writebackup = false
set.updatetime = 200

-- set.clipboard = "unnamedplus"
set.grepprg = "rg --vimgrep"
set.grepformat = "%f:%l:%c:%m"

-- set.splitbelow = true
-- set.splitright = true

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap = true })

-----------------------------------------------------------
---- lazy.nvim                                            |
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "\\"
local opts = {
  install = {
    colorscheme = { "monokai-pro" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        -- "rplugin",
        "editorconfig",
      },
    },
  },
}
require("lazy").setup("plugins", opts)

vim.cmd [[colorscheme monokai-pro]]

-----------------------------------------------------------
---- lua specific indentation                             |
-----------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "lua" then
      set.tabstop = 2
      set.softtabstop = 2
      set.shiftwidth = 2
    end
  end
})

-----------------------------------------------------------
---- neovide specific config                              |
-----------------------------------------------------------
vim.o.guifont = "CaskaydiaCove Nerd Font:h12"
vim.api.nvim_set_keymap("", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Insert>", "<C-R>+", { noremap = true, silent = true })
if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_cursor_vfx_mode = "pixeldust"
end
