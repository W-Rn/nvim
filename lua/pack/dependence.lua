-- ==============================================================
-- 公共依赖库 — 立即加载，供其他插件 require()
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
}, { confirm = false })
-- 这些库在 init.lua 阶段即被 packadd!，无需额外配置
-- 其他插件通过 require("plenary.xxx") 等按需引用
