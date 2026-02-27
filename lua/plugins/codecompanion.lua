return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.diff",
        },
        -- stylua: ignore
        keys = {
            {"<leader>cca", "<CMD>CodeCompanionActions<CR>",     mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion actions"      },
            {"<leader>cci", "<CMD>CodeCompanion<CR>",            mode = {"n"},      noremap = true, silent = true, desc = "CodeCompanion inline"       },
            {"<leader>cci", "<CMD>'<,'>CodeCompanion<CR>",       mode = {"v"},      noremap = true, silent = true, desc = "CodeCompanion inline"       },
            {"<leader>ccc", "<CMD>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion chat (toggle)"},
            {"<leader>ccp", "<CMD>CodeCompanionChat Add<CR>",    mode = {"v"}     , noremap = true, silent = true, desc = "CodeCompanion chat add code"},
        },

        opts = {
            adapters = {
                http = {
                    siliconflow = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            env = {
                                url = "https://api.siliconflow.cn",
                                api_key = function()
                                    return os.getenv "DEEPSEEK_API_KEY_S"
                                end,
                                chat_url = "/v1/chat/completions",
                            },
                            schema = {
                                model = {
                                    default = "deepseek-ai/DeepSeek-V3",
                                },
                            },
                        })
                    end,
                    deepseek = function()
                        return require("codecompanion.adapters").extend("deepseek", {
                            env = {
                                api_key = function()
                                    return os.getenv "DEEPSEEK_API_KEY"
                                end,
                            },
                            schema = {
                                model = {
                                    default = "deepseek-chat",
                                },
                            },
                        })
                    end,
                },
            },
            display = {
                diff = {
                    enabled = true,
                    provider = "mini_diff",
                },
            },

            strategies = {
                -- chat = { adapter = "copilot" },
                -- inline = { adapter = "copilot" },
                chat = { adapter = "siliconflow" },
                inline = { adapter = "siliconflow" },
                -- chat = { adapter = "deepseek" },
                -- inline = { adapter = "copilot" },
            },

            opts = {
                language = "Chinese", -- "English"|"Chinese"
            },
        },
    },
}
