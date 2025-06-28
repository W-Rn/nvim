local function safe_cmd(cmd)
  return function()
    vim.cmd(cmd)
  end
end

local runners = {
  c = function()
    vim.cmd "split"
    vim.cmd "resize 100"
    vim.cmd "term gcc % -o %< && ./%< && rm -f ./%<"
  end,
  cpp = function()
    vim.cmd "split"
    vim.cmd "resize 100"
    vim.cmd "term g++ -w % -std=c++17 -O2 -g -Wall -o %< && ./%< && rm -f ./%<"
  end,
  markdown = safe_cmd "MarkdownPreview",
  html = safe_cmd "LiveServer start",
  python = function()
    vim.cmd "split"
    vim.cmd "set nonumber"
    vim.cmd "set norelativenumber"
    vim.cmd "resize 10"
    vim.cmd "term python3 %"
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
