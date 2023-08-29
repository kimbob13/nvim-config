# nvim-config
Due to requirements of some plugins, recommend [latest release of Neovim](https://github.com/neovim/neovim/releases/tag/stable) or nightly version

## Prerequisite
- C, C++ compiler: For [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- LSP server
    - [clangd](https://clangd.llvm.org/): For C LSP
    - [python-lsp-server](https://github.com/python-lsp/python-lsp-server): For Python LSP
    - [lua-language-server](https://github.com/LuaLS/lua-language-server): For Lua LSP
- [ripgrep](https://github.com/BurntSushi/ripgrep): For [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) live grep
- [cscope](https://cscope.sourceforge.net/): For [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim)
- [bear](https://github.com/rizsotto/Bear) (Optional): For C LSP. Using `compile_commands.json`, the syntax highlighting could be more informative.

### C, C++ Compiler
```sh
# Debian / Ubuntu
sudo apt install build-essential

# Fedora
sudo dnf install gcc gcc-c++

# Arch
sudo pacman -S gcc

# FreeBSD ships with pre-installed C/C++ compiler
```

### clangd
```sh
# Debian / Ubuntu
sudo apt install clangd

# Fedora
sudo dnf install clang-tools-extra

# Arch
sudo pacman -S clang

# FreeBSD ships with pre-installed clangd
# But its binary name is something like 'clangd15', so I make a symbolic link to it.
sudo ln -s /usr/local/bin/clangd15 /usr/local/bin/clangd
```

You can also download latest release from official [GitHub](https://github.com/clangd/clangd/releases). Download zip file, unzip, and export the `bin` directory of clangd to `$PATH`.

### python-lsp-server
```sh
# pip
pip install python-lsp-server

# apt (Ubuntu, Debian)
sudo apt install python3-pylsp
```

### lua-language-server
- Download latest release from [GitHub](https://github.com/LuaLS/lua-language-server/releases).
- You need to export `bin` directory of `lua-language-server` to `$PATH`.
    - I use a method from [official lua-language-server wiki](https://github.com/LuaLS/lua-language-server/wiki/Getting-Started#command-line), which makes a shell script in the directory belong to `$PATH`
- Example
    1. Make the file with contents below and name it as `lua-language-server`. You should make this file executable.
        ```sh
        #!/bin/bash
        exec "<path-to-directory>/bin/lua-language-server" "$@"
        ```
    2. Save this file in `$HOME/.local/bin`. You can use your own preferred directory, just make sure it is exported to `$PATH`

### ripgrep
```sh
# Debian / Ubuntu
sudo apt install ripgrep

# Fedora
sudo dnf install ripgrep

# Arch
sudo pacman -S ripgrep

# FreeBSD
sudo pkg install ripgrep
```

### cscope
```sh
# Debian / Ubuntu
sudo apt install cscope

# Fedora
sudo dnf install cscope

# Arch
sudo pacman -S cscope

# FreeBSD
sudo pkg instlal cscope
```

### bear (Optional)
```sh
# Debian / Ubuntu
sudo apt install bear

# Fedora
sudo dnf install bear

# Arch
sudo pacman -S bear

# FreeBSD
sudo pkg install bear
```

## Language-specific Settings and Remarks.
### C
- In the [cscope_maps.nvim configuration](lua/plugins/cscope_maps.lua), I set a default keymap for `:Cscope build` as <kbd>F5</kbd>.
- Since cscope_maps.nvim do not support origianl `:cs` command (only `:Cscope`), I make a alias so that `:cs` becomes `:Cscope`
- You may build your own C projects with [**bear**](https://github.com/rizsotto/Bear) to generate `compile_command.json`. It would help colorscheme plugin make more accurate syntax highlighting.
