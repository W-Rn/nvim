return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  event = "User LoadDirectory", -- 仅在加载目录时触发
  keys = {
    { "<leader>e", desc = "Toggle Neo-Tree" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "LoadTheme",
      callback = function()
        vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { link = "WinSeparator" })
        vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })
      end,
    })
  end,
  config = function()
    require("neo-tree").setup {
      close_if_last_window = true, -- 当只剩文件树窗口时自动退出
      window = {
        position = "left", -- 必须与 edgy 的布局位置一致
        width = 30,
        mappings = {
          ["<cr>"] = "none",
          ["h"] = "close_node", -- 关闭目录（类似 nvim-tree 的 h）
          ["l"] = "open", -- 打开文件/目录（类似 nvim-tree 的 l）
          ["<C-t>"] = "open_tabnew", -- 在新标签页打开（类似 nvim-tree 的 <C-t>）
          ["<C-v>"] = "open_vsplit", -- 垂直分屏打开
          ["<C-s>"] = "open_split", -- 水平分屏打开   },
        },
        filesystem = {
          filtered_items = {
            visible = true, -- 显示隐藏文件（与原配置一致）
          },
        },
      },
    }
    -- 定义大纲检测函数
    local special_buffers = {
      "Outline",
      "symbols-outline",
      "undotree",
      "neo-tree-popup",
      "tagbar",
    }
    _G.is_outline_window = function()
      local buf_ft = vim.bo.filetype
      for _, ft in ipairs(special_buffers) do
        if buf_ft == ft then
          return true
        end
      end
      return string.match(vim.api.nvim_buf_get_name(0), "OUTLINE$") ~= nil
    end
    -- 安全开关映射（避开outline）
    vim.keymap.set("n", "<leader>e", function()
      if not is_outline_window() then
        require("neo-tree.command").execute { toggle = true }
      else
        vim.notify("禁止在当前buffer中打开文件树", vim.log.levels.WARN)
      end
    end, { desc = "Toggle Neo-Tree" })
  end,
}
