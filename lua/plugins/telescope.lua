return {
    "nvim-telescope/telescope.nvim",
    event = "BufReadPre",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: find files" })
        vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope: live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: search buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: help tags" })
        vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope: git commits" })
        vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope: git branches" })
        vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: git status" })
    end,
    opts = {
        defaults = {
            borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
    end,
}
