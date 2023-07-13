return {
    "nvim-telescope/telescope.nvim",
    event = "BufReadPre",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
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
