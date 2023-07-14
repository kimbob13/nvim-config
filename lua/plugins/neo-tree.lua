return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    keys = {
        {
            "<C-n>",
            "<CMD>Neotree toggle=true<CR>",
            mode = "n",
            noremap = true,
            desc = "Neo Tree"
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        close_if_last_window = false,
        window = { width = 30 },
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
    end,
}
