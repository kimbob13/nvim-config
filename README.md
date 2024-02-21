# nvim-config
Due to requirements of some plugins, recommend to use [latest release of Neovim](https://github.com/neovim/neovim/releases/tag/stable) or nightly version

## Prerequisite
- git
- C, C++ compiler: For [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [ripgrep](https://github.com/BurntSushi/ripgrep): For [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) live grep
- [cscope](https://cscope.sourceforge.net/): For [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim)
- [bear](https://github.com/rizsotto/Bear) (Optional): For C LSP. Using `compile_commands.json`, the syntax highlighting could be more informative.

### Debian / Ubuntu
```sh
sudo apt install git
sudo apt install build-essential # C/C++ compiler
sudo apt install ripgrep
sudo apt install cscope
sudo apt install bear
```

### Arch Linux
```sh
sudo pacman -S git
sudo pacman -S gcc # g++ included in this package
sudo pacman -S ripgrep
sudo pacman -S cscope
sudo pacman -S bear
```

### Fedora
```sh
sudo dnf install git
sudo dnf install gcc gcc-c++
sudo dnf install ripgrep
sudo dnf install cscope
sudo dnf install bear
```


### Windows
- Recommend to use [Scoop](https://scoop.sh/) package manager
- `bear` is not supported in [Windows](https://github.com/rizsotto/Bear/wiki/Usage#windows)
```sh
scoop install git
scoop install gcc
scoop install ripgrep
scoop install cscope
```

### macOS
- Recommend to use [Homebrew](https://brew.sh/) package manager
- Default C/C++ compiler in macOS is `clang`, which can be installed with Xcode command line tools
- `git` also can be installed with Xcode command line tools
```sh
brew install ripgrep
brew install cscope
brew install bear
```

### FreeBSD
- FreeBSD ships with pre-installed C/C++ compiler (`clang`)
```sh
sudo pkg install git
sudo pkg install ripgrep
sudo pkg install cscope
sudo pkg install bear
```

## Plugins List
### Explicit
- [barbecue.nvim](https://github.com/utilyre/barbecue.nvim)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim)
- [dashboard-nvim](https://github.com/glepnir/dashboard-nvim)
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [hlargs.nvim](https://github.com/m-demare/hlargs.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [leap.nvim](https://github.com/ggandor/leap.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mini.indentscope](https://github.com/echasnovski/mini.indentscope)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [neovim-session-manager](https://github.com/Shatur/neovim-session-manager)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-surround](https://github.com/kylechui/nvim-surround)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim_context_vt](https://github.com/haringsrob/nvim_context_vt)
- [outline.nvim](https://github.com/hedyhli/outline.nvim)
- [telescope-live-grep-args.nvim](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)
- [which-key.nvim](https://github.com/folke/which-key.nvim)

### Implicit (only for dependency)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp-snippy](https://github.com/dcampos/cmp-snippy)
- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [nvim-navic](https://github.com/SmiteshP/nvim-navic)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-snippy](https://github.com/dcampos/nvim-snippy)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [vim-repeat](https://github.com/tpope/vim-repeat)

## Language-specific Settings and Remarks.
### C
- In the [cscope_maps.nvim configuration](lua/plugins/cscope_maps.lua), I set a default keymap for `:Cscope build` as <kbd>F5</kbd>.
- Since cscope_maps.nvim do not support origianl `:cs` command (only `:Cscope`), I make a alias so that `:cs` becomes `:Cscope`
- You may build your own C projects with [**bear**](https://github.com/rizsotto/Bear) to generate `compile_command.json`. It would help colorscheme plugin make more accurate syntax highlighting.
