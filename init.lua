-- ==============================================================
-- Neovim 入口配置 (nvim0.12.2)
-- 加载顺序: 核心选项 → 按键 → 自动命令 → 插件(vim.pack.add) → 折叠
-- ==============================================================
-- vim.g.startuptime = vim.fn.reltime()

vim.g.startuptime = vim.uv.hrtime()
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("pack.plugins")

require("core.folding")
require("core.run")
