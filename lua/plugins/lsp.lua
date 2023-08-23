local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "dcampos/nvim-snippy",
        "dcampos/cmp-snippy",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp = require("cmp")
        local snippy = require("snippy")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local ts_utils = require("nvim-treesitter.ts_utils")

        -----------------------------------------------------------
        ---- nvim-cmp setup                                       |
        -----------------------------------------------------------
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("snippy").expand_snippet(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif snippy.can_expand_or_advance() then
                        snippy.expand_or_advance()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif snippy.can_jump(-1) then
                        snippy.previous()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
                    { name = "snippy" },
                },
                {
                    { name = "buffer" },
                }
            ),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                { name = "cmdline" }
            })
        })

        -----------------------------------------------------------
        ---- nvim-autopairs with nvim-cmp                         |
        -----------------------------------------------------------
        local ts_node_func_parens_disabled = {
            named_imports = true,
            use_declaration = true,
        }
        local default_handler = cmp_autopairs.filetypes["*"]["("].handler

        cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
            local node_type = ts_utils.get_node_at_cursor():type()
            if ts_node_func_parens_disabled[node_type] then
                if item.data then
                    item.data.funcParensDisabled = true
                else
                    char = ""
                end
            end

            default_handler(char, item, bufnr, rules, commit_character)
        end

        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done({
                sh = false,
            })
        )

        -----------------------------------------------------------
        ---- lsp config                                           |
        -----------------------------------------------------------
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig.clangd.setup {
            capabilities = capabilities,
        }
        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = {"W391"},
                            maxLineLength = 100,
                        }
                    }
                }
            },
            capabilities = capabilities,
        }
        lspconfig.rust_analyzer.setup {
            on_attach = function(client)
                require"completion".on_attach(client)
            end,
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true,
                    },
                },
            },
            capabilities = capabilities,
        }
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telementry = {
                        enable = false,
                    },
                },
            },
            capabilities = capabilities,
        }
    end,
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

return M
