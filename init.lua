-----------------------------------------------------------
---- set options                                          |
-----------------------------------------------------------
local set = vim.opt

-- Tab size
set.expandtab = true
set.smarttab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

set.smartindent = true
set.autoindent = true

set.mouse = "a"
set.hidden = true
set.inccommand = ""
set.incsearch = true
set.ttimeoutlen = 0
set.wildmenu = true
set.completeopt = { "menu", "menuone", "noselect" }

set.number = true
set.cursorline = true
set.signcolumn = "yes:1"
set.title = true
set.encoding = "UTF-8"
set.background = "dark"
set.termguicolors = true

set.swapfile = false
set.backup = false
set.writebackup = false
set.updatetime = 300

-- set.clipboard = "unnamedplus"
set.grepprg = "rg --vimgrep"
set.grepformat = "%f:%l:%c:%m"

set.relativenumber = true
-- set.splitbelow = true
-- set.splitright = true

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap=true })

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
        "--branch=stable", -- latest stable release
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
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "rplugin",
                "editorconfig",
            },
        },
    },
}
require("lazy").setup("plugins", opts)

vim.cmd[[colorscheme monokai-pro]]
