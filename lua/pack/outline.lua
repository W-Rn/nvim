-- ==============================================================
-- 代码大纲 — <leader>o 按键懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/hedyhli/outline.nvim" } }, { load = function() end, confirm = false })

local outline_loaded = false
local function ensure_outline()
    if outline_loaded then
        return
    end
    outline_loaded = true
    vim.cmd.packadd("outline.nvim")
    require("outline").setup({
        outline_window = {
            focus_on_open = false,
        },
    })
end

-- 特殊窗口中禁止打开
local outline_blocked = { "codediff-explorer", "qf", "neo-tree", "nvim-undotree", "neo-tree-popup", "toggleterm" }
vim.keymap.set("n", "<leader>to", function()
    if vim.tbl_contains(outline_blocked, vim.bo.filetype) then
        vim.notify("禁止在当前buffer中打开大纲", vim.log.levels.WARN)
        return
    end
    ensure_outline()
    vim.cmd("Outline")
end, { desc = "Lsp Outline" })
