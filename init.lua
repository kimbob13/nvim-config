-----------------------------------------------------------
---- set options and keymap                               |
-----------------------------------------------------------
local set = vim.opt

-- Tab size
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

set.mouse = "a"
set.hidden = true
set.inccommand = "split"
set.incsearch = true
set.ttimeoutlen = 0
set.wildmenu = true
set.completeopt = {"menuone", "noinsert", "noselect"}

set.number = true
set.cursorline = true
set.signcolumn = "yes:1"
set.title = true
set.encoding = "UTF-8"
set.background = "dark"
set.termguicolors = true

-- set.relativenumber = true
-- set.splitbelow = true
-- set.splitright = true

-- new vsplit of go to definition command
vim.keymap.set("n", "<C-[>", ":vert winc ]<CR>", { noremap = true })

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
require("lazy").setup("plugins", {
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
            },
        },
    },
})
