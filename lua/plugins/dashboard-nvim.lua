local neovim_header = {
	[[                                                    ]],
	[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
	[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
	[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
	[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
	[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
	[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
	[[                                                    ]],
}

return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { {"nvim-tree/nvim-web-devicons"}},
    opts = {
        theme = "hyper",
        shortcut_type = "number",
        hide = {
            statusline = true,
            tabline = false,
            winbar = false,
        },
        config = {
            header = neovim_header,
            week_header = {
                enable = false,
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
                    desc = " Dotfiles",
                    group = "Number",
                    action = "Telescope find_files hidden=true",
                    key = "d",
                },
                {
                    desc = "󰊳 Check Update",
                    group = "@property",
                    action = "Lazy check", key = "c"
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
