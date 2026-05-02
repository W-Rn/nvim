-- 设置 Leader 键
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- vim.keymap.set({ "i", "v" }, "ii", "<Esc>", { noremap = true, silent = true })
-- 窗口导航
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { desc = "切换到下方的分割窗口" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { desc = "切换到上方的分割窗口" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { desc = "切换到右侧的分割窗口" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { desc = "切换到左侧的分割窗口" })

-- 增强滚动
vim.keymap.set("n", "<S-j>", "5j", { desc = "向下滚动 5 行" })
vim.keymap.set("n", "<S-k>", "5k", { desc = "向上滚动 5 行" })

-- 禁用默认键
vim.keymap.set({ "n", "v" }, "s", "<nop>")
vim.keymap.set({ "n", "v" }, "S", "<nop>")
vim.keymap.set({ "n", "x" }, "gra", "<nop>")
vim.keymap.set("n", "grn", "<nop>")
vim.keymap.set("n", "gri", "<nop>")
vim.keymap.set("n", "grr", "<nop>")
vim.keymap.set("n", "grt", "<nop>")
vim.keymap.set("n", "grx", "<nop>")
vim.keymap.set("n", "gd", "<nop>")
vim.keymap.set("n", "gO", "<nop>")

-- 窗口大小调整
vim.keymap.set("n", "<Up>", ":res +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ":res -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>u", ":Undotree<CR>", { noremap = true, silent = true })

-- mark
local mark_chars = {}
for i = string.byte("a"), string.byte("z") do
    table.insert(mark_chars, string.char(i))
end
for i = string.byte("A"), string.byte("Z") do
    table.insert(mark_chars, string.char(i))
end

for _, key in ipairs(mark_chars) do
    vim.keymap.set("n", "m" .. key, function()
        return "m" .. key .. "<Cmd>redraw!<CR>"
    end, { expr = true, desc = "Set Mark" .. key })

    vim.keymap.set("n", "dm" .. key, function()
        vim.cmd("delmarks " .. key)
        vim.cmd("redraw!")
    end, { silent = true, desc = "Remove Mark" .. key })
end

-- ==========================================
-- 行/块 移动快捷键 (Alt + s/w)
-- ==========================================
vim.keymap.set("n", "<A-s>", "<Cmd>m .+1<CR>==", { desc = "向下移动当前行" })
vim.keymap.set("n", "<A-w>", "<Cmd>m .-2<CR>==", { desc = "向上移动当前行" })
vim.keymap.set("v", "<A-s>", ":m '>+1<CR>gv=gv", { desc = "向下移动选中块", silent = true })
vim.keymap.set("v", "<A-w>", ":m '<-2<CR>gv=gv", { desc = "向上移动选中块", silent = true })
vim.keymap.set("i", "<A-s>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "向下移动当前行" })
vim.keymap.set("i", "<A-w>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "向上移动当前行" })
vim.keymap.set("n", "<leader>st", function()
    local elapsed = vim.fn.reltimestr(vim.fn.reltime(vim.g.startuptime))
    vim.notify("Neovim 启动耗时: " .. elapsed .. " 秒", vim.log.levels.INFO)
end, { desc = "显示启动耗时" })
