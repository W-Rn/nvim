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
-- codecompanion
vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionChatOpened",
  callback = function()
    vim.wo.colorcolumn = "0"
    vim.opt_local.number = false -- 关闭行号
    vim.opt_local.relativenumber = false -- 关闭相对行号
  end,
})
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
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
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

-- float help
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "checkhealth" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    vim.api.nvim_win_close(0, true) -- 关闭原窗口
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      border = "rounded",
    })
    vim.wo.colorcolumn = "0"
    vim.wo.winbar = ""
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end,
      desc = "Automatically close help floating window when leaving",
      group = vim.api.nvim_create_augroup("HelpFloatClose", { clear = false }),
    })
  end,
})
