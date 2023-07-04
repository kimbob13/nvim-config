return {
    {
        "echasnovski/mini.surround",
        version = false,
        enabled = false,
        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        config = function()
            require("mini.indentscope").setup()
        end,
    }
}
