-- ==============================================================
-- 单词高亮 — 首个文件读取时激活 (BufReadPost)
-- ==============================================================

vim.pack.add({ { src = "https://github.com/RRethy/vim-illuminate" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("BufReadPost", {
    once = true,
    callback = function()
        vim.cmd.packadd("vim-illuminate")
        require("illuminate").configure({
            delay = 0,
            under_cursor = false,
            filetypes_denylist = { "NeoTree" },
            modes_denylist = { "i", "v" },
        })
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IncSearch" })
    end,
})
