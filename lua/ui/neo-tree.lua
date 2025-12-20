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
  config = function()
    require("neo-tree").setup {
      close_if_last_window = true, -- 当只剩文件树窗口时自动退出
      window = {
        position = "left", -- 必须与 edgy 的布局位置一致
        width = 30,
        mappings = {
          -- ["r"] = "none",
          ["<cr>"] = "none",
          -- -- 基础操作
          -- --["<leader>e"] = "toggle_node", -- 切换节点展开/折叠
          ["h"] = "close_node", -- 关闭目录（类似 nvim-tree 的 h）
          ["l"] = "open", -- 打开文件/目录（类似 nvim-tree 的 l）
          -- ["q"] = "close_window", -- 关闭文件树窗口
          ["<C-t>"] = "open_tabnew", -- 在新标签页打开（类似 nvim-tree 的 <C-t>）
          -- ["a"] = "add", -- 新建文件/目录
          -- ["dd"] = "delete", -- 删除文件/目录
          -- ["yy"] = "copy_to_clipboard", -- 复制
          -- ["p"] = "paste_from_clipboard", -- 粘贴
          -- ["rn"] = "rename", -- 重命名
          --
          -- -- 高级操作
          -- ["S"] = "fuzzy_finder", -- 模糊搜索文件
          -- --["gr"] = "git_refresh", -- 刷新 Git 状态
          -- ["[g"] = "prev_git_modified", -- 上一个 Git 修改的文件
          -- ["]g"] = "next_git_modified", -- 下一个 Git 修改的文件
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
