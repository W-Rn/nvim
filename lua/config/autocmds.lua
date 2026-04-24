-- 判断当前缓冲区是否为目录
local path = vim.fn.expand "%:p"
if vim.fn.filereadable(path) == 1 then
else
    -- print "当前缓冲区是目录"
    vim.api.nvim_exec_autocmds("User", {
        pattern = "LoadDirectory",
    })
end
-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("kickstart_highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
    pattern = {
        "checkhealth",
        "help",
        "qf",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd "close"
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})
-- =====================================================================
-- Chezmoi 管理
-- =====================================================================

-- local chezmoi_dir = vim.fn.expand "~/.local/share/chezmoi"
--
-- -- 1. 拦截器：当你打开主目录的受管文件时，自动重定向到源目录
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     group = vim.api.nvim_create_augroup("ChezmoiRedirect", { clear = true }),
--     callback = function(args)
--         local filepath = vim.api.nvim_buf_get_name(args.buf)
--
--         if filepath == "" or filepath:match "^[a-z]+://" then
--             return
--         end
--
--         if filepath:sub(1, #chezmoi_dir) == chezmoi_dir then
--             return
--         end
--
--         vim.defer_fn(function()
--             for _, win in ipairs(vim.api.nvim_list_wins()) do
--                 local ok, val = pcall(vim.api.nvim_win_get_var, win, "neo_tree_preview")
--                 if ok and val == 1 then
--                     return
--                 end
--             end
--
--             if not vim.api.nvim_buf_is_valid(args.buf) then
--                 return
--             end
--
--             local obj = vim.system({ "chezmoi", "source-path", filepath }, { text = true }):wait()
--
--             if obj.code == 0 and obj.stdout then
--                 local source_path = vim.trim(obj.stdout)
--
--                 if source_path ~= "" and source_path ~= filepath then
--                     vim.cmd("edit " .. vim.fn.fnameescape(source_path))
--
--                     local old_buf = args.buf
--                     vim.schedule(function()
--                         if vim.api.nvim_buf_is_valid(old_buf) then
--                             vim.bo[old_buf].buflisted = false
--                             pcall(vim.api.nvim_buf_delete, old_buf, { force = true })
--                         end
--                     end)
--
--                     vim.notify("✨ 已拦截并重定向至源文件", vim.log.levels.INFO, { title = "Chezmoi" })
--                 end
--             end
--         end, 150)
--     end,
-- })
--
-- -- 2. 触发器：当你在源目录保存文件时，自动执行 apply 使其生效
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = vim.api.nvim_create_augroup("ChezmoiAutoApply", { clear = true }),
--     -- 只有当保存的文件路径在 ~/.local/share/chezmoi 下时才触发
--     pattern = chezmoi_dir .. "/*",
--     callback = function(args)
--         local filepath = vim.api.nvim_buf_get_name(args.buf)
--
--         -- 在后台异步执行 chezmoi apply，绝对不卡主线程
--         -- --source-path 参数确保只 apply 你刚刚保存的这一个文件，速度极快
--         vim.system({ "chezmoi", "apply", "--source-path", filepath }, { text = true }, function(out)
--             vim.schedule(function()
--                 if out.code == 0 then
--                     vim.notify("🚀 配置已自动生效 (apply 成功)", vim.log.levels.INFO, { title = "Chezmoi" })
--                 else
--                     vim.notify(
--                         "❌ 自动 apply 失败:\n" .. (out.stderr or ""),
--                         vim.log.levels.ERROR,
--                         { title = "Chezmoi Error" }
--                     )
--                 end
--             end)
--         end)
--     end,
-- })
