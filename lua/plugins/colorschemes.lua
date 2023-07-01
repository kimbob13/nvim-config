return {
    {
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
        },
        config = function(_, opts)
            local monokai = require("monokai-pro")
            monokai.setup(opts)
            monokai.load()
        end,
    },
    {
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
    },
    {
        "folke/tokyonight.nvim",
        enabled = false,
        opts = {
            style = "storm",
            styles = {
                comments = { italic = false },
                keywords = { italic = false },
                functions = { italic = false },
                variables = { italic = false },
            },
        },
    },
}
