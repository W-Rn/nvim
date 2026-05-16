-- ==============================================================
-- Markdown 预览 (peek.nvim) — ft=markdown 懒加载
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/toppair/peek.nvim" },
}, { load = function() end, confirm = false })

-- ft=markdown 时加载并注册按键
vim.api.nvim_create_autocmd("FileType", {
    once = true,
    pattern = { "markdown" },
    callback = function()
        vim.cmd.packadd("peek.nvim")
        require("peek").setup({
            auto_load = false,
            app = "browser",
        })

        vim.keymap.set("n", "<leader>mp", function()
            local peek = require("peek")
            if peek.is_open() then
                peek.close()
            else
                peek.open()
            end
        end, { buffer = true, desc = "Peek Markdown Preview" })
    end,
})
