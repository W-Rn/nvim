return {
    {
        "folke/flash.nvim",
        -- event = "VeryLazy",
        opts = {
            label = {
                rainbow = {
                    enabled = true,
                    shade = 1,
                },
            },
            modes = {
                char = {
                    enabled = false,
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[Flash] Jump", },
            { "<leader>l", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "[Flash] Treesitter", },
            -- { "<leader>F", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "[Flash] Treesitter Search", },
            { "<c-f>", mode = {"x", "n", "c" }, function() require("flash").toggle() end, desc = "[Flash] Toggle Search", },
            {
                "<leader>J",
                mode = { "n", "x", "o" },
                function()
                require("flash").jump {
                    search = { mode = "search", max_length = 0 },
                    label = { after = { 0, 0 }, matches = false },
                    jump = { pos = "end" },
                    pattern = "^\\s*\\S\\?",
                }
                end,
                desc = "[Flash] Line jump",
            },
            -- {
            --     "<leader>k",
            --     mode = { "n", "x", "o" },
            --     function()
            --         require("flash").jump {
            --         search = { mode = "search", max_length = 0 },
            --         label = { after = { 0, 0 }, matches = false },
            --         jump = { pos = "end" },
            --         pattern = "^\\s*\\S\\?", -- match non-whitespace at start plus any character (ignores empty lines)
            --         }
            --     end,
            --     desc = "[Flash] Line jump",
            -- },
        },
    },
}
