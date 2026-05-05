-- ==============================================================
-- 代码大纲 — <leader>o 按键懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/hedyhli/outline.nvim" } }, { load = function() end, confirm = false })

local outline_loaded = false
vim.keymap.set("n", "<leader>to", function()
    if not outline_loaded then
        outline_loaded = true
        vim.cmd.packadd("outline.nvim")
        require("outline").setup({
            outline_window = {
                focus_on_open = false,
            },
        })
    end
    vim.cmd("Outline")
end, { desc = "Lsp Outline" })
