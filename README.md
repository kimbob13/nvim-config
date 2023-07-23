# nvim-config
Because of several plugins' requirements, recommend [latest release of Neovim](https://github.com/neovim/neovim/releases/tag/stable) or nightly version

## Prerequisite
- [Node.js](https://nodejs.org), [npm](https://www.npmjs.com/): For [coc.nvim](https://github.com/neoclide/coc.nvim)
- [clangd](https://clangd.llvm.org/): For C LSP and coc-clangd
- [pyright](https://github.com/microsoft/pyright): For coc-pyright
- [ripgrep](https://github.com/BurntSushi/ripgrep): For [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) live grep
- [cscope](https://cscope.sourceforge.net/): For [cscope_maps.nvim](https://github.com/dhananjaylatkar/cscope_maps.nvim)
- [bear](https://github.com/rizsotto/Bear) (Optional): For C LSP. It could generate more accurate syntax highlighting

## Prerequisite Install - Common
### Pyright
Since `pyright` is installed with `npm`, you can install `pyright` after installing `npm`.
```sh
sudo npm i -g pyright
```

Then, you may install [coc-pyright](https://github.com/fannheyward/coc-pyright) in the nvim with below.
```
:CocInstall coc-pyright
```

### coc-clangd
**After installing `clangd`** for each environment, you may install [coc-clangd](https://github.com/clangd/coc-clangd) in the nvim with below.
```
:CocInstall coc-clangd
```

## Prerequisite Install - Debian, Ubuntu
Tested with Debian 12 (bookworm) and Ubuntu 22.04 LTS

### Node.js
Install Node.js using [nodesource](https://github.com/nodesource/distributions#installation-instructions)

I use LTS version of Node.js

```sh
# Debian (as root)
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
apt-get install -y nodejs

# Ubuntu
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
```

### clangd
There are two options for installing clangd. I prefer the first option.

1. Using system package manager
    ```sh
    sudo apt install clangd
    ```

2. Using coc.nvim. You need to install [coc-clangd](https://github.com/clangd/coc-clangd) extension first.
    - clangd installed in this way may cause some issue ([#](https://github.com/clangd/coc-clangd/issues/577))
    ```
    :CocInstall coc-clangd
    :CocCommand clangd.install
    ```

### Others
Install using system package manager
```sh
sudo apt install ripgrep
sudo apt install cscope
sudo apt install bear
```

## Prerequisite Install - Fedora
Tested with Fedora 38

You can install all the prerequisites using system package manager.
```sh
sudo dnf install nodejs
sudo dnf install clang-tools-extra # for clangd
sudo dnf install ripgrep
sudo dnf install cscope
sudo dnf install bear
```

In Fedora, nvim-treesitter [may fail at initial compilation](https://github.com/nvim-treesitter/nvim-treesitter/issues/961). In this case, you need to install `gcc-c++`
```sh
sudo dnf install gcc-c++
```

## Prerequisite Install - Arch Linux
You can install all the prerequisites using system package manager.

```sh
sudo pacman -S nodejs-lts-hydrogen # for Node.js 18.x LTS
sudo pacman -S clang # for clangd
sudo pacman -S ripgrep
sudo pacman -S cscope
sudo pacman -S bear
```

## Prerequisite Install - FreeBSD
Tested with FreeBSD-13.2 RELEASE

### clangd
Since FreeBSD use LLVM/clang as default C compiler, clangd is pre-installed with OS.

But its binary name is something like `clangd15`, I make a symbolic link to it.
```sh
sudo ln -s /usr/local/bin/clangd15 /usr/local/bin/clangd
```

### Others
You can install all the other prerequisites using system package manager.

```sh
sudo pkg install node
sudo pkg install ripgrep
sudo pkg instlal cscope
sudo pkg install bear
```

## Language-specific Settings and Remarks.
### 1. C
- In the [cscope_maps.nvim configuration](lua/plugins/cscope_maps.lua), I set a default keymap for `:Cscope build` as <kbd>F5</kbd>.
- You may build your own C projects with [**bear**](https://github.com/rizsotto/Bear) to generate `compile_command.json`.

### 2. Lua
- You may install Lua LSP manually, or with [coc-lua](https://github.com/josa42/coc-lua) coc.nvim extensions
    - I prefer `coc-lua` approach, because it installs [lua-language-server](https://github.com/LuaLS/lua-language-server) automatically in Linux. (not FreeBSD)
        - In FreeBSD, you can install `lua-language-server` with system package manager
            ```sh
            sudo pkg install lua-language-server
            ```
    - `coc-lua` install `lua-language-server` in the `$HOME/.config/coc/extensions/coc-lua-data/lua-language-server` directory
        - In FreeBSD, it is not the case, so I couldn't find a way of using `coc-lua` extension. But Lua LSP is still usable, so I satisfy with this currently..
- In any case, you need to export `bin` directory of `lua-language-server` to `$PATH`.
    - I use a method from [official lua-language-server wiki](https://github.com/LuaLS/lua-language-server/wiki/Getting-Started#command-line), which make a shell script in the directory belong to `$PATH`
- Example
    1. Make the file with contents below and name it as `lua-language-server`. You should make this file executable.
        ```sh
        #!/bin/bash
        exec "<path-to-directory>/bin/lua-language-server" "$@"
        ```
    2. Save this file in `$HOME/.local/bin`. You can use your own preferred directory, just make sure it is exported to `$PATH`
    3. Install `coc-lua` in the nvim
        ```
        :CocInstall coc-lua
        ```
- Because nvim use Lua as its script engine, it uses some global variables, such as `vim`.
    - Without any configuration, Lua LSP and `coc-lua` generate warning that `vim` variable is "unknown global".
    - So I create default configuration for suppressing this warning in [nvim-lspconfig plugin configuration](lua/plugins/lsp.lua) and [coc settings](coc-settings.json)