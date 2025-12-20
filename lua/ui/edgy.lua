return {
  --"folke/edgy.nvim",
  "folke/edgy.nvim",
  enabled = true,
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    -- 定义布局块
    options = {
      left = { size = 30 },
      right = { size = 40 },
      top = { size = 10 },
      bottom = { size = 10 },
    },
    left = { -- 左侧布局块
      {
        title = "Neo-Tree", -- 块标题
        ft = "neo-tree", -- 关联的文件类型（需与文件树插件匹配）
        pinned = false,
        open = "NeoTree",
        wo = {
          winbar = false, -- 禁用独立winbar
        },
      },
      {
        title = "Undo-Tree", -- 块标题
        ft = "undotree", -- 关联的文件类型（需与文件树插件匹配）
        pinned = true, -- 始终显示
        open = "UndotreeToggle",
        wo = {
          winbar = false, -- 禁用独立winbar
        },
      },
    },
    right = {
      {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "Outline",
        wo = {
          winbar = false, -- 禁用独立winbar
        },
      },
    },
    icons = {
      closed = " ",
      open = " ",
    },
  },
}
