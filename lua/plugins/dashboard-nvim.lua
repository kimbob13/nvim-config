return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { {"nvim-tree/nvim-web-devicons"}},
    opts = {
    theme = "hyper",
        config = {
            week_header = {
                enable = true,
            },
            shortcut = {
                {
                    icon = " ",
                    icon_hl = "@variable",
                    desc = "Files",
                    group = "Label",
                    action = "Telescope find_files",
                    key = "f",
                },
                {
                    desc = " dotfiles",
                    group = "Number",
                    action = "Telescope find_files hidden=true",
                    key = "d",
                },
                {
                    desc = "󰊳 Updates",
                    group = "@property",
                    action = "Lazy update", key = "u"
                },
                {
                    desc = " Profile",
                    group = "DiagnosticHint",
                    action = "Lazy profile",
                    key = "p",
                },
            },
        },
    },
    config = function(_, opts)
        require("dashboard").setup(opts)
    end,
}
