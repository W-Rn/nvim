-- 判断当前缓冲区是否为目录
local path = vim.fn.expand "%:p"
if vim.fn.filereadable(path) == 1 then
-- print "当前缓冲区是文件"
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
