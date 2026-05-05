-- ==============================================================
-- 文件书签 — 按键懒加载 (<leader>ha, <leader>hl)
-- ==============================================================
vim.pack.add(
    { { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" } },
    { load = function() end, confirm = false }
)

local harpoon_loaded = false
local function ensure_harpoon()
    if harpoon_loaded then
        return
    end
    harpoon_loaded = true
    vim.cmd.packadd("harpoon")
    require("harpoon"):setup()
end

vim.keymap.set("n", "<leader>ha", function()
    ensure_harpoon()
    require("harpoon"):list():add()
end, { desc = "Harpoon File" })

vim.keymap.set("n", "<leader>hl", function()
    ensure_harpoon()
    require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Harpoon Quick Menu" })

for i = 1, 5 do
    local idx = i -- 必须创建一个局部变量来锁定当前循环的值
    vim.keymap.set("n", "<leader>" .. idx, function()
        ensure_harpoon()
        require("harpoon"):list():select(idx)
    end, { desc = "Harpoon to File " .. idx })
end
