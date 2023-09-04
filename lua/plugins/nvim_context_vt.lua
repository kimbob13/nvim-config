return {
    "haringsrob/nvim_context_vt",
    event = "BufReadPost",
    opts = {
        disable_virtual_lines = true,
    },
    config = function(_, opts)
        require("nvim_context_vt").setup(opts)
    end,
}
