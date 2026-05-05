-- ==============================================================
-- 文件树 — <leader>e 按键懒加载
-- 特殊窗口（Outline/undotree/tagbar）中禁用文件树
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

    -- 特殊窗口类型列表（在这些窗口中禁止打开文件树）
    local special_buffers = { "Outline", "symbols-outline", "undotree", "neo-tree-popup", "tagbar" }
    _G.is_outline_window = function()
        local buf_ft = vim.bo.filetype
        for _, ft in ipairs(special_buffers) do
            if buf_ft == ft then
                return true
            end
        end
        return string.match(vim.api.nvim_buf_get_name(0), "OUTLINE$") ~= nil
    end

    vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { link = "WinSeparator" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })
end

vim.keymap.set("n", "<leader>tn", function()
    if not _G.is_outline_window or not _G.is_outline_window() then
        ensure_neotree()
        require("neo-tree.command").execute({ toggle = true })
    else
        vim.notify("禁止在当前buffer中打开文件树", vim.log.levels.WARN)
    end
end, { desc = "Toggle Neo-Tree" })
