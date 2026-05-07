-- ==============================================================
-- 文件树 — <leader>e 按键懒加载
-- 特殊窗口（Outline/undotree）中禁用文件树
-- ==============================================================

vim.pack.add({ { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" } }, { load = function() end, confirm = false })

local neotree_loaded = false
local function ensure_neotree()
    if neotree_loaded then
        return
    end
    neotree_loaded = true
    vim.cmd.packadd("neo-tree.nvim")
    require("neo-tree").setup({
        close_if_last_window = true,
        window = {
            position = "left",
            width = 50,
            mappings = {
                ["<cr>"] = "none",
                ["h"] = "close_node",
                ["l"] = "open",
            },
        },
    })

    vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { link = "WinSeparator" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })
end

-- 特殊窗口中禁止打开
local neo_tree_blocked = { "codediff-explorer", "qf", "Outline", "nvim-undotree", "neo-tree-popup", "toggleterm" }
vim.keymap.set("n", "<leader>tn", function()
    if vim.tbl_contains(neo_tree_blocked, vim.bo.filetype) then
        vim.notify("禁止在当前buffer中打开文件树", vim.log.levels.WARN)
        return
    end
    ensure_neotree()
    require("neo-tree.command").execute({ toggle = true })
end, { desc = "Toggle Neo-Tree" })
