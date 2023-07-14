return {
    "nvim-telescope/telescope.nvim",
    event = "BufReadPre",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
    end,
}
