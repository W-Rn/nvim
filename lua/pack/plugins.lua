-- ==============================================================
-- 4a. 公共依赖（立即加载，其他插件运行时依赖）
-- ==============================================================
require("pack.config.dependence")

-- ==============================================================
-- 4b. 主题（依赖 devicons，需尽早设置 colorscheme）
-- ==============================================================
require("pack.config.catppuccin")

-- ==============================================================
-- 4c. 立即加载的功能插件（无懒加载条件）
-- ==============================================================
require("pack.config.treesitter")
require("pack.config.schemastore")
require("pack.config.snacks")

-- ==============================================================
-- 4d. VimEnter 事件懒加载（Nvim 完全启动后激活）
-- ==============================================================
require("pack.config.lualine")
require("pack.config.edgy")
require("pack.config.noice")
require("pack.config.which-key")
require("pack.config.lspconfig")
require("pack.config.opencode")

-- ==============================================================
-- 4e. 其他事件懒加载
-- ==============================================================
require("pack.config.bufferline") -- BufReadPost
require("pack.config.git") -- gitsigns/chezmoi(VimEnter) + lazygit(keys)
require("pack.config.mini") -- mini.surround/ai/diff(VimEnter) + mini.files(keys)
require("pack.config.lspsaga") -- LspAttach
require("pack.config.neogen") -- LspAttach
require("pack.config.vim-illuminate") -- BufReadPost
require("pack.config.format") -- BufWritePre

-- ==============================================================
-- 4f. 按键懒加载（首次按下特定按键时激活）
-- ==============================================================
require("pack.config.flash")
require("pack.config.neo-tree")
require("pack.config.toggleterm")
require("pack.config.outline")
require("pack.config.harpoon")

-- ==============================================================
-- 4g. 文件类型 / InsertEnter 懒加载
-- ==============================================================
require("pack.config.blink") -- InsertEnter + PackChanged 构建 hook
require("pack.config.lazydev") -- ft=lua
require("pack.config.render-markdown") -- ft=markdown, opencode_output
require("pack.config.venv-selector") -- ft=python

-- ==============================================================
-- 4h. 工具插件（多事件混合懒加载）
-- ==============================================================
require("pack.config.utils")
