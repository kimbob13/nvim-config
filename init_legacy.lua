-----------------------------------------------------------
---- some shortcuts                                       |
-----------------------------------------------------------
local set = vim.opt
local keyset = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
---- set options                                          |
-----------------------------------------------------------
-- Tab size
set.expandtab = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

set.mouse = 'a'
set.hidden = true
set.inccommand = 'split'
set.incsearch = true
set.ttimeoutlen = 0
set.wildmenu = true
set.completeopt = {'menuone', 'noinsert', 'noselect'}

set.number = true
set.cursorline = true
set.signcolumn = 'yes:1'
set.title = true
set.encoding = 'UTF-8'
set.background = 'dark'
set.termguicolors = true

-- set.relativenumber = true
-- set.splitbelow = true
-- set.splitright = true

-----------------------------------------------------------
---- keymaps                                              |
-----------------------------------------------------------
-- keyset('n', '<C-t>', ':enew<Enter>', { noremap = true })
keyset('n', '<C-h>', ':bprevious<Enter>', { noremap = true })
keyset('n', '<C-l>', ':bnext<Enter>', { noremap = true })
-- keyset('n', '<C-q>', ':bp <BAR> bd #<Enter>')

keyset('n', '<C-n>', ':Neotree toggle=true<CR>', { noremap = true })
keyset('n', '<F8>', ':SymbolsOutline<CR>', { noremap = true })

-----------------------------------------------------------
---- vim-plug                                             |
-----------------------------------------------------------
local Plug = vim.fn['plug#']

vim.call('plug#begin')

---- Colorschemes
Plug 'loctvl842/monokai-pro.nvim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'folke/tokyonight.nvim'
Plug 'navarasu/onedark.nvim'
-- Plug 'jacoborus/tender.vim'
-- Plug 'elvessousa/sobrio'

---- vim target
Plug 'bounceme/poppy.vim'

---- neovim target
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.2' })
Plug('nvim-neo-tree/neo-tree.nvim', { branch = 'v2.x' })
Plug('akinsho/bufferline.nvim', { tag = '*' })
Plug 'nvim-lualine/lualine.nvim'
Plug 'dhananjaylatkar/cscope_maps.nvim'
Plug 'folke/noice.nvim'

-- utils
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/symbols-outline.nvim'
Plug 'RRethy/vim-illuminate'
Plug 'windwp/nvim-autopairs'
Plug 'karb94/neoscroll.nvim'

-- dependency
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-tree/nvim-web-devicons'

-- git plugin
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'

vim.call('plug#end')

-- load plugins
require('noice').setup()
require('symbols-outline').setup()
require('nvim-autopairs').setup()
require('neoscroll').setup()
require('gitsigns').setup()

-- lsp config
require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.rust_analyzer.setup{}

-----------------------------------------------------------
---- colorschemes                                         |
-----------------------------------------------------------
require("monokai-pro").setup({
    devicons = true, -- highlight the icons of `nvim-web-devicons`
    styles = {
        comment = { italic = false },
        keyword = { italic = false }, -- any other keyword
        type = { italic = false }, -- (preferred) int, long, char, etc
        storageclass = { italic = false }, -- static, register, volatile, etc
        structure = { italic = false }, -- struct, union, enum, etc
        parameter = { italic = false }, -- parameter pass in function
        annotation = { italic = false },
        tag_attribute = { italic = false }, -- attribute of tag in reactjs
    },
    filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    background_clear = {
        "notify",
    },
})
vim.cmd([[colorscheme monokai-pro]])

-- vim.cmd([[colorscheme vim-monokai-tasty]])

require('tokyonight').setup({
    style = 'storm',
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
    },
})
-- vim.cmd('colorscheme tokyonight-storm')

require('onedark').setup {
    style = 'darker',
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
}
-- require('onedark').load()

-----------------------------------------------------------
---- lualine.nvim                                         |
-----------------------------------------------------------
local whitespace = '\u{2632} '

function trailing_whitespaces()
    local space = vim.fn.search([[\s\+$]], 'nwc')
    return space ~= 0 and whitespace.."["..space.."]".."trailing" or ""
end

function mixed_indent()
    local space_pat = [[\v^ +]]
    local tab_pat = [[\v^\t+]]
    local space_indent = vim.fn.search(space_pat, 'nwc')
    local tab_indent = vim.fn.search(tab_pat, 'nwc')

    local mixed = (space_indent > 0 and tab_indent > 0)
    local mixed_same_line
    if not mixed then
        mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
        mixed = mixed_same_line > 0
    end

    if not mixed then return '' end
    if mixed_same_line ~= nil and mixed_same_line > 0 then
        return whitespace..'['..mixed_same_line..']'..'mix-indent'
    end

    local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
    local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
    if space_indent_cnt > tab_indent_cnt then
        return whitespace..'['..tab_indent..']'..'mix-indent'
    else
        return whitespace..'['..space_indent..']'..'mix-indent'
    end
end

function line_numbers()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local total_lines = vim.api.nvim_buf_line_count(0)
    local progress = math.floor((row / total_lines) * 100)

    col = col + 1

    local progress_str
    if row == 1 then
        progress_str = 'Top '
    else
        progress_str = progress..'%% '
    end

    return progress_str..'\u{e0a1}:'..row..'/'..total_lines..'\u{2630}'..' \u{e0a3}:'..col
end

require('lualine').setup {
    options = {
        theme = 'onedark',
    },
    sections = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_y = { line_numbers, 'searchcount' },
        lualine_z = { trailing_whitespaces, mixed_indent },
    },
}

-----------------------------------------------------------
---- bufferline.nvim                                      |
-----------------------------------------------------------
require('bufferline').setup {
    options = {
        themable = true,
        separator_style = 'slant',
    }
}

-----------------------------------------------------------
---- telescope.nvim                                       |
-----------------------------------------------------------
require("telescope").setup({
    defaults = {
      borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
    }
})

-----------------------------------------------------------
---- nvim-treesitter                                      |
-----------------------------------------------------------
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "python", "lua", "vim", "vimdoc", "query", "diff" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

require'treesitter-context'.setup {
    enable = true,
}

-----------------------------------------------------------
---- coc.nvim                                             |
-----------------------------------------------------------
-- Some servers have issues with backup files, see #649
set.backup = false
set.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
set.updatetime = 300

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-----------------------------------------------------------
---- cscope_maps.nvim                                     |
-----------------------------------------------------------
require('cscope_maps').setup({
    cscope = {
        picker = 'telescope',
        skip_picker_for_single_result = true,
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

-----------------------------------------------------------
---- neo-tree.nvim                                        |
-----------------------------------------------------------
require("neo-tree").setup({
    close_if_last_window = true,
    window = {
        width = 30,
    },
})

-----------------------------------------------------------
---- diffview.nvim                                        |
-----------------------------------------------------------
require("diffview").setup({
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
})

-----------------------------------------------------------
---- vim-illuminate                                       |
-----------------------------------------------------------
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
})

-----------------------------------------------------------
---- poppy.vim                                            |
-----------------------------------------------------------
local Poppy = augroup('Poppy', {})
autocmd(
    'CursorMoved',
    {
        pattern = '*',
        command = 'call PoppyInit()',
        group = Poppy,
    }
)

vim.g.poppy = 1
vim.cmd("command! PoppyToggle :call clearmathces() | let g:poppy = -get(g:, 'poppy', -1) | exe 'au! Poppy CusrsorMoved *' . (g:poppy > 0 ? ' call PoppyInit()' : '')")

vim.api.nvim_set_hl(0, 'PoppyLevel1', {bg = '#F0961E', fg = '#000000', bold = true})
vim.api.nvim_set_hl(0, 'PoppyLevel2', {bg = '#3296F0', fg = '#000000', bold = true})
vim.api.nvim_set_hl(0, 'PoppyLevel3', {bg = '#96F032', fg = '#000000', bold = true})
vim.api.nvim_set_hl(0, 'PoppyLevel4', {bg = '#E650DC', fg = '#000000', bold = true})
vim.api.nvim_set_hl(0, 'PoppyLevel5', {bg = '#F1FF32', fg = '#000000', bold = true})
vim.api.nvim_set_hl(0, 'PoppyLevel6', {bg = '#FF4032', fg = '#000000', bold = true})
vim.g.poppyhigh = {
    'PoppyLevel1', 'PoppyLevel2', 'PoppyLevel3',
    'PoppyLevel4', 'PoppyLevel5', 'PoppyLevel6'
}
