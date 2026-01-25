local runners = {
  c = function()
    vim.cmd 'TermExec cmd="gcc % -o %< && ./%< && rm -f ./%<" go_back=0'
  end,
  cpp = function()
    vim.cmd 'TermExec cmd="g++ -w % -std=c++17 -O2 -g -Wall -o %< && ./%< && rm -f ./%<" go_back=0'
  end,
  -- markdown = function()
  --   vim.cmd "MarkdownPreview"
  -- end,
  python = function()
    vim.cmd 'TermExec cmd="python3 %" go_back=0'
  end,
}

local function enhanced_run()
  local ft = vim.bo.filetype
  local runner = runners[ft]
  if runner then
    local ok, err = pcall(runner)
    if not ok then
      vim.notify("执行失败: " .. err, vim.log.levels.ERROR)
    end
  else
    vim.notify("未定义的运行器: " .. ft, vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<F36>", enhanced_run, {
  silent = true,
  desc = "󰐅 智能运行当前文件",
})
