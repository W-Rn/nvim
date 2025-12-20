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
        hide_extensions = true,
        show_all_buffers = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = " Neo-Tree",
            text_align = "left",
            highlight = "Directory",
            separator = true,
            padding = 0,
          },
          {
            filetype = "undotree",
            text = "󰑖 Undo History",
            text_align = "left",
            highlight = "Special",
            separator = true,
            padding = 0,
          },
          {
            filetype = "Outline",
            text = "󰘓 Code Outline",
            text_align = "left",
            highlight = "Label",
            separator = true,
            padding = 0,
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
