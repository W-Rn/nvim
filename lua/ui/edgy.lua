return {
  --"folke/edgy.nvim",
  "folke/edgy.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 可选：支持图标显示
  },
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  config = function()
    require("edgy").setup {
      -- 定义布局块
      left = { -- 左侧布局块
        {
          --title = "*********File Tree********", -- 块标题
          title = "File Tree",
          ft = "neo-tree", -- 关联的文件类型（需与文件树插件匹配）
          size = { width = 30 }, -- 固定宽度
          pinned = false, -- 始终显示
        },
        {
          title = "Undo Tree",
          ft = "undotree", -- 关联的文件类型（需与文件树插件匹配）
          size = { width = 30 }, -- 固定宽度
          pinned = false, -- 始终显示
        },
      },
      right = {
        {
          title = "Outline",
          ft = "Outline",
          pinned = false,
          -- open = "Outline",
          size = { width = 30 }, -- 固定宽度
        },
      },
    }
  end,
}
