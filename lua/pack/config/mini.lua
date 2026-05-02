-- ==============================================================
-- Mini 系列插件 — 极简功能集合
-- mini.files: <leader>mf 按键懒加载
-- mini.surround/ai/diff: VimEnter 懒加载
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.files" },
    { src = "https://github.com/nvim-mini/mini.ai" },
    { src = "https://github.com/nvim-mini/mini.diff" },
    { src = "https://github.com/nvim-mini/mini.surround" },
}, { load = function() end, confirm = false })

-- mini.files — 按键懒加载
local mini_files_loaded = false
local function ensure_mini_files()
    if mini_files_loaded then
        return
    end
    mini_files_loaded = true
    vim.cmd.packadd("mini.files")
    local MiniFiles = require("mini.files")
    MiniFiles.setup({
        mappings = {
            show_help = "g?",
            synchronize = "<CR>",
        },
        options = {
            use_as_default_explorer = false,
        },
    })

    -- 窗口居中辅助函数
    local function center_window(win_id)
        local screen_w = vim.o.columns
        local screen_h = vim.o.lines
        local window_w = math.floor(screen_w * 0.4)
        local window_h = math.floor(screen_h * 0.7)
        local row = math.floor((screen_h - window_h) / 2)
        local col = math.floor((screen_w - window_w) / 2)
        local config = vim.api.nvim_win_get_config(win_id)
        config.relative = "editor"
        config.row = row
        config.col = col
        config.width = window_w
        config.height = window_h
        vim.api.nvim_win_set_config(win_id, config)
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
            local config = vim.api.nvim_win_get_config(args.data.win_id)
            config.border = "rounded"
            config.title_pos = "right"
            vim.api.nvim_win_set_config(args.data.win_id, config)
        end,
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
            center_window(args.data.win_id)
        end,
    })
end

vim.keymap.set("n", "<leader>mf", function()
    ensure_mini_files()
    require("mini.files").open()
end, { desc = "Mini.files" })

-- mini.surround — VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("mini.surround")
    end,
})

-- mini.ai — VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("mini.ai")
    end,
})

-- mini.diff — VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("mini.diff")
        require("mini.diff").setup({
            view = {
                style = "sign",
                signs = {
                    add = "▎",
                    change = "▎",
                    delete = "",
                },
            },
        })
        vim.keymap.set("n", "<leader>md", function()
            if vim.b.minidiff_summary then
                require("mini.diff").toggle_overlay(0)
            else
                vim.notify("mini.diff 在此缓冲区未启用 (可能不在 Git 仓库中)", vim.log.levels.WARN)
            end
        end, { desc = "Toggle mini.diff overlay" })
    end,
})
