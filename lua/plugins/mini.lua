return {
    {
        "echasnovski/mini.files",
        version = "*",
        keys = { "<leader>mf", desc = "Open MiniFiles" },
        config = function()
            local MiniFiles = require "mini.files"
            MiniFiles.setup {
                mappings = {
                    show_help = "g?",
                    synchronize = "<CR>",
                },
                options = {
                    use_as_default_explorer = false,
                },
            }
            local center_window = function(win_id)
                -- 1. 获取 Neovim 当前窗口（编辑器）的 100% 宽度和高度
                local screen_w = vim.o.columns
                local screen_h = vim.o.lines

                -- 2. 动态设置 mini.files 的尺寸（按比例计算，或者按你喜欢的固定值）
                local window_w = math.floor(screen_w * 0.4)
                local window_h = math.floor(screen_h * 0.7)

                -- 3. 计算居中所需的起始坐标 (公式：(总宽 - 窗口宽) / 2)
                local row = math.floor((screen_h - window_h) / 2)
                local col = math.floor((screen_w - window_w) / 2)

                -- 4. 获取并修改当前窗口配置
                local config = vim.api.nvim_win_get_config(win_id)
                config.relative = "editor"
                config.row = row
                config.col = col
                config.width = window_w -- 这里会强制拉伸每一列的宽度
                config.height = window_h

                -- 5. 应用配置
                vim.api.nvim_win_set_config(win_id, config)
            end
            -- 装饰：设置边框和标题
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowOpen",
                callback = function(args)
                    local config = vim.api.nvim_win_get_config(args.data.win_id)
                    config.border, config.title_pos = "rounded", "right"
                    vim.api.nvim_win_set_config(args.data.win_id, config)
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowUpdate",
                callback = function(args)
                    center_window(args.data.win_id)
                end,
            })

            vim.keymap.set("n", "<leader>mf", MiniFiles.open, { desc = "Open MiniFiles" })
        end,
    },
    {
        "echasnovski/mini.surround",
        version = "*",
        event = "VeryLazy",
        config = true,
        keys = {
            { "s", "<NOP>", mode = { "n", "x", "o" } },
        },
    },

    {
        "echasnovski/mini.ai",
        version = "*",
        -- event = "BufReadPost",
        event = "VeryLazy",
        config = true,
    },

    {
        "nvim-mini/mini.diff",
        event = "VeryLazy",
        keys = {
            {
                "<leader>md",
                function()
                    -- 检查当前缓冲区是否已经开启了 mini.diff
                    if vim.b.minidiff_summary then
                        require("mini.diff").toggle_overlay(0)
                    else
                        vim.notify(
                            "mini.diff 在此缓冲区未启用 (可能不在 Git 仓库中)",
                            vim.log.levels.WARN
                        )
                    end
                end,
                desc = "Toggle mini.diff overlay",
            },
        },
        opts = {
            view = {
                style = "sign",
                signs = {
                    add = "▎",
                    change = "▎",
                    delete = "",
                },
            },
        },
    },
}
