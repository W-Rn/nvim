-- ==============================================================
-- 光标跳转 — 按键懒加载 (<leader>j/l/J, <c-f>)
-- 多个按键映射共享同一加载函数
-- ==============================================================

vim.pack.add({ { src = "https://github.com/folke/flash.nvim" } }, { load = function() end, confirm = false })

local flash_loaded = false
local function ensure_flash()
    if flash_loaded then
        return
    end
    flash_loaded = true
    vim.cmd.packadd("flash.nvim")
    require("flash").setup({
        label = {
            rainbow = {
                enabled = true,
                shade = 1,
            },
        },
        modes = {
            char = {
                enabled = false,
            },
        },
    })
end

vim.keymap.set({ "n", "x", "o" }, "<leader>j", function()
    ensure_flash()
    require("flash").jump()
end, { desc = "Flash jump" })

vim.keymap.set({ "n", "x", "o" }, "<leader>l", function()
    ensure_flash()
    require("flash").treesitter()
end, { desc = "Flash treesitter" })

vim.keymap.set({ "x", "n", "c" }, "<c-f>", function()
    ensure_flash()
    require("flash").toggle()
end, { desc = "Flash toggle" })

vim.keymap.set({ "n", "x", "o" }, "<leader>J", function()
    ensure_flash()
    require("flash").jump({
        search = { mode = "search", max_length = 0 },
        label = { after = { 0, 0 }, matches = false },
        jump = { pos = "end" },
        pattern = "^\\s*\\S\\?",
    })
end, { desc = "Flash jump end" })
