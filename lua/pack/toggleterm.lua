-- ==============================================================
-- 浮动终端 — :ToggleTerm + :TermExec + <A-\> 按键懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/akinsho/toggleterm.nvim" } }, { load = function() end, confirm = false })

local loaded = false

local function load_toggleterm()
    if loaded then
        return
    end
    loaded = true
    vim.api.nvim_del_user_command("ToggleTerm")
    vim.api.nvim_del_user_command("TermExec")
    vim.cmd.packadd("toggleterm.nvim")
    require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
    })
end

-- 按键映射
vim.keymap.set({ "n", "t" }, "<A-\\>", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- 临时 :ToggleTerm 命令
vim.api.nvim_create_user_command("ToggleTerm", function(opts)
    load_toggleterm()
    require("toggleterm").toggle_command(opts.args, opts.count)
end, { count = true, nargs = "*" })

-- 临时 :TermExec 命令（供 run.lua / 命令行直接调用）
vim.api.nvim_create_user_command("TermExec", function(opts)
    load_toggleterm()
    require("toggleterm").exec_command(opts.args, opts.count)
end, { count = true, nargs = "*" })
