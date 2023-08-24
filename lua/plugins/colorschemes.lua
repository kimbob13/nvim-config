local monokai_pro = {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        transparent_background = false,
        devicons = true,
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
        plugins = {
            bufferline = {
                underline_selected = true,
            },
        }
    },
    config = function(_, opts)
        require("monokai-pro").setup(opts)
    end,
}

local onedark = {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = {
        style = "darker",
        code_style = {
            comments = "none",
            keywords = "none",
            functions = "none",
            strings = "none",
            variables = "none"
        },
    },
}

local tokyonight = {
    "folke/tokyonight.nvim",
    opts = {
        style = "storm",
        styles = {
            comments = { italic = false },
            keywords = { italic = false },
            functions = { italic = false },
            variables = { italic = false },
        },
        on_highlights = function(hl, c)
            local prompt = "#2d3149"
            hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = c.fg_dark,
            }
            hl.TelescopeBorder = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
            hl.TelescopePromptNormal = {
                bg = prompt,
            }
            hl.TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
            }
            hl.TelescopePromptTitle = {
                bg = prompt,
                fg = prompt,
            }
            hl.TelescopePreviewTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
            hl.TelescopeResultsTitle = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
        end,
    },
}

local M = { monokai_pro, tokyonight, onedark }

return M
