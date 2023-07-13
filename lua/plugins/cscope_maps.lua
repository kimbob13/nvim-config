return {
    "dhananjaylatkar/cscope_maps.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        -- convert cs command to Cscope
        vim.cmd([[
            fun! SetupCommandAlias(from, to)
                exec 'cnoreabbrev <expr> '.a:from
                \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
                \ .'? ("'.a:to.'") : ("'.a:from.'"))'
            endfun
            call SetupCommandAlias("cs", "Cscope")
        ]])
    end,
    opts = {
        cscope = {
            picker = "telescope",
            skip_picker_for_single_result = true,
            db_build_cmd_args = { "-bcqvR" },
        },
    },
    config = function(_, opts)
        require("cscope_maps").setup(opts)
    end,
}
