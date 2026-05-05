-- ==============================================================
-- 编辑辅助工具集合
-- colorizer: BufReadPost,BufNewFile,VimEnter 混合事件懒加载
-- autopairs: InsertEnter 懒加载
-- trim: BufWritePre 懒加载
-- todo-comments: VimEnter 懒加载
-- rainbow-delimiters: BufReadPost,BufNewFile 懒加载
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/cappyzawa/trim.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
}, { load = function() end, confirm = false })

-- colorizer
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "VimEnter" }, {
    once = true,
    callback = function()
        vim.cmd.packadd("nvim-colorizer.lua")
    end,
})

-- autopairs
vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("nvim-autopairs")
        require("nvim-autopairs").setup({})
    end,
})

-- trim
vim.api.nvim_create_autocmd("BufWritePre", {
    once = true,
    callback = function()
        vim.cmd.packadd("trim.nvim")
        require("trim").setup({})
    end,
})

-- todo-comments
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("todo-comments.nvim")
        require("todo-comments").setup({})
    end,
})

-- rainbow-delimiters
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.cmd.packadd("rainbow-delimiters.nvim")
        require("rainbow-delimiters.setup").setup({})
    end,
})
