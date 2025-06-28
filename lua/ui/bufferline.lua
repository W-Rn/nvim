return {
  --"akinsho/bufferline.nvim"
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  enabled = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup {
      options = {
        custom_filter = function(buf_number)
          local bt = vim.bo[buf_number].buftype
          local ft = vim.bo[buf_number].filetype
          local name = vim.api.nvim_buf_get_name(buf_number)
          -- 排除条件
          local exclude = bt ~= ""
            or name:match "%[Scratch%]"
            or ft == "qf"
            or name:match "^term://"
            or ft == "help"
            or ft == "nofile"
            or name:match "Neogit"
            or not vim.bo[buf_number].buflisted -- 新增：排除未列出的缓冲区
          return not exclude
        end,
        hide_extensions = true,
        show_all_buffers = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "W-Rn", -- 块标题
            -- text = " ", -- 块标题
            text_align = "left",
            separator = true,
            padding = 0,
            height = 2,
          },
        },
        tab_size = 10, -- 根据实际调整
      },
      highlights = {
        buffer_selected = {
          bold = true, -- 当前选中标签粗体
          italic = false, -- 当前选中标签斜体
        },
      },
    }
    -- 按键映射
    vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", { desc = "BufferLineCycleNext" })
    vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", { desc = "BufferLineCyclePrev" })
    -- vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "BufferLine delete" }) -- 关闭当前缓冲区
    -- vim.keymap.set("n", "<leader>bD", "<Cmd>BufferLineCloseOthers<CR>", { desc = "BufferLine close others" }) -- 关闭其他缓冲区
    vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", { desc = "BufferLine move next" }) -- 向右移动缓冲区位置
    vim.keymap.set("n", "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", { desc = "BufferLine move prev" }) -- 向左移动缓冲区位置
    vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "BufferLine TogglePin" }) --
  end,
}
