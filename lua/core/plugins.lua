-- ==============================================================
-- 4a. 公共依赖（立即加载，其他插件运行时依赖）
-- ==============================================================
require("pack.dependence")

-- ==============================================================
-- 4b. 主题（依赖 devicons，需尽早设置 colorscheme）
-- ==============================================================
require("pack.catppuccin")

-- ==============================================================
-- 4c. 立即加载的功能插件（无懒加载条件）
-- ==============================================================
require("pack.treesitter")
require("pack.schemastore")
require("pack.snacks")

-- ==============================================================
-- 4d. VimEnter 事件懒加载（Nvim 完全启动后激活）
-- ==============================================================
require("pack.lualine")
require("pack.edgy")
require("pack.noice")
require("pack.which-key")
require("pack.lspconfig")
require("pack.opencode")

-- ==============================================================
-- 4e. 其他事件懒加载
-- ==============================================================
require("pack.bufferline") -- BufReadPost
require("pack.git") -- gitsigns/chezmoi(VimEnter) + lazygit(keys)
require("pack.mini") -- mini.surround/ai/diff(VimEnter) + mini.files(keys)
require("pack.neogen") -- LspAttach
require("pack.vim-illuminate") -- BufReadPost
require("pack.format") -- BufWritePre

-- ==============================================================
-- 4f. 按键懒加载（首次按下特定按键时激活）
-- ==============================================================
require("pack.flash")
require("pack.oil")
require("pack.neo-tree")
require("pack.toggleterm")
require("pack.outline")
require("pack.harpoon")

-- ==============================================================
-- 4g. 文件类型 / InsertEnter 懒加载
-- ==============================================================
require("pack.blink") -- InsertEnter + PackChanged 构建 hook
require("pack.lazydev") -- ft=lua
require("pack.render-markdown") -- ft=markdown, opencode_output
require("pack.venv-selector") -- ft=python

-- ==============================================================
-- 4h. 工具插件（多事件混合懒加载）
-- ==============================================================
require("pack.utils")
