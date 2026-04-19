return {
    --"folke/edgy.nvim",
    "folke/edgy.nvim",
    enabled = true,
    event = "VeryLazy",
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
    opts = {
        animate = {
            enabled = false,
        },
        -- 定义布局块
        options = {
            left = { size = 50 },
            right = { size = 50 },
            top = { size = 10 },
            bottom = { size = 15 },
        },
        bottom = {
            {
                title = "Terminal",
                ft = "toggleterm",
                pinned = false,
                open = function()
                    require("toggleterm").toggle()
                end,
                wo = {
                    winbar = true,
                },
            },
            {
                ft = "qf",
                title = function()
                    local qf_info = vim.fn.getqflist { title = 0 }
                    local qf_title = qf_info.title or ""
                    if qf_title:lower():find "git" or qf_title:lower():find "hunk" then
                        return "󰊢 Gitsigns"
                    elseif qf_title:lower():find "diagnostics" or qf_title == "" or qf_title == "Quickfix" then
                        return "󱖫 Diagnostics"
                    end

                    return qf_title
                end,
                pinned = false,
                wo = {
                    winbar = true,
                },
            },
        },
        left = { -- 左侧布局块
            {
                title = "Neo-Tree", -- 块标题
                ft = "neo-tree", -- 关联的文件类型（需与文件树插件匹配）
                pinned = false,
                open = "NeoTree",
                wo = {
                    winbar = false, -- 禁用独立winbar
                },
            },
            {
                title = "Undo-Tree", -- 块标题
                ft = "undotree", -- 关联的文件类型（需与文件树插件匹配）
                pinned = false, -- 始终显示
                open = "UndotreeToggle",
                wo = {
                    winbar = false, -- 禁用独立winbar
                },
            },
        },
        right = {
            {
                title = "Outline",
                ft = "Outline",
                pinned = true,
                open = "Outline",
                wo = {
                    winbar = false, -- 禁用独立winbar
                },
            },
        },
        icons = {
            closed = " ",
            open = " ",
        },
    },
}
