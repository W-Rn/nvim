return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = { "ToggleTerm", "TermExec" },
        keys = { "<A-\\>" },
        opts = {
            size = 15,
            open_mapping = [[<A-\>]],
            direction = "horizontal",
        },
    },
}
