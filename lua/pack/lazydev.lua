-- ==============================================================
-- Lua 开发辅助 — ft=lua 文件类型懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/folke/lazydev.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("FileType", {
    once = true,
    pattern = "lua",
    callback = function()
        vim.cmd.packadd("lazydev.nvim")
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        })
    end,
})
