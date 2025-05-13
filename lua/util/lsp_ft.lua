-- key: lsp server name in nvim-lspconfig
-- value: corresponding filetype in nvim and its option
return {
  clangd = {
    ft = { "c", "cpp" },
    opts = {
      cmd = { "clangd", "--header-insertion=never" },
    },
  },
  pylsp = {
    ft = { "python" },
    opts = {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = {
                "W391", -- blank line at end of file
                "W503", -- line break before binary operator
                "E203", -- whitespace before :
                "E221", -- multiple spaces before operator
              },
              maxLineLength = 100
            }
          }
        }
      },
    },
  },
  lua_ls = {
    ft = { "lua" },
    opts = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library"
              -- "${3rd}/busted/library"
            }
          },
        },
      },
    },
  },
  rust_analyzer = {
    ft = { "rust" },
    opts = {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          },
          -- cargo = {
          --   target = "riscv32i-unknown-none-elf",
          -- },
          -- checkOnSave = {
          --   allTargets = false,
          -- },
        },
      },
    },
  },
  ts_ls = { ft = { "javascript", "typescript" }, opts = {} },
  volar = { ft = { "vue" }, opts = {} },
  eslint = { ft = { "javascript", "typescript" }, opts = {} },
  solargraph = { ft = { "ruby" }, opts = {} },
  jsonls = { ft = { "json", "jsonc" }, opts = {} },
  yamlls = { ft = { "yaml", "yaml.docker-compose" }, opts = {} },
  dockerls = { ft = { "dockerfile" }, opts = {} },
}
