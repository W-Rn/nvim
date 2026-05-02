-- ==============================================================
-- AI 助手 (opencode.nvim) — VimEnter 懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/sudo-tee/opencode.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("opencode.nvim")
        require("opencode").setup({
            keymap_prefix = "<leader>a",
        })
    end,
})
