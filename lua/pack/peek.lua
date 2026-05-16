-- ==============================================================
-- Markdown 预览 (peek.nvim) — <leader>mp 按键懒加载
-- 构建命令（deno task build:fast）通过 PackChanged 自动执行
-- 前置依赖：Deno 运行时
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/toppair/peek.nvim" },
}, { load = function() end, confirm = false })

-- 按键懒加载
local peek_loaded = false
local function ensure_peek()
    if peek_loaded then return end
    peek_loaded = true
    vim.cmd.packadd("peek.nvim")
    require("peek").setup({
        auto_load = true,
        close_on_bdelete = true,
        syntax = true,
        theme = "dark",
        update_on_change = true,
        app = "webview",
    })
end

vim.keymap.set("n", "<leader>mp", function()
    ensure_peek()
    local peek = require("peek")
    if peek.is_open() then
        peek.close()
    else
        peek.open()
    end
end, { desc = "Peek Markdown Preview" })
