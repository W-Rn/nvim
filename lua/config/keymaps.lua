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

-- 禁用默认 键
vim.keymap.set("n", "s", "<nop>")
vim.keymap.set({ "n", "x" }, "gra", "<nop>")
vim.keymap.set("n", "grn", "<nop>")
vim.keymap.set("n", "gri", "<nop>")
vim.keymap.set("n", "grr", "<nop>")
vim.keymap.set("n", "gd", "<nop>")

-- -- 窗口大小调整
vim.keymap.set("n", "<Up>", ":res +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", ":res -1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", { noremap = true, silent = true })

-- mark
for c = string.byte "a", string.byte "z" do
  local key = string.char(c)
  vim.keymap.set("n", "m" .. key, function()
    return "m" .. key .. "<Cmd>redrawstatus<CR>"
  end, { expr = true, noremap = true })
end

for c = string.byte "A", string.byte "Z" do
  local key = string.char(c)
  vim.keymap.set("n", "m" .. key, function()
    return "m" .. key .. "<Cmd>redrawstatus<CR>"
  end, { expr = true, noremap = true })
end

for c = string.byte "a", string.byte "z" do
  local key = string.char(c)
  vim.keymap.set("n", "dm" .. key, function()
    vim.cmd("delmarks " .. key)
    vim.cmd "redrawstatus"
  end, { noremap = true })
end
for c = string.byte "A", string.byte "Z" do
  local key = string.char(c)
  vim.keymap.set("n", "dm" .. key, function()
    vim.cmd("delmarks " .. key)
    vim.cmd "redrawstatus"
  end, { noremap = true })
end
