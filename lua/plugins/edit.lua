return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    },
  },

  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    opts = {},
  },

  {
    "mbbill/undotree",
    lazy = true,
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo-tree" },
    },
    init = function()
      vim.g.undotree_DiffAutoOpen = 0
      vim.cmd [[
      if has("persistent_undo")
         let target_path = expand('~/.undodir')
         if !isdirectory(target_path)
             call mkdir(target_path, "p", 0700)
         endif
         let &undodir=target_path
         set undofile
       endif
     ]]
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    -- keys = {
    --   { "<leader>to", "<Cmd>TodoTelescope<CR>", desc = "Telescope Todo" },
    -- },
    config = true,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "rainbow-delimiters.setup",
    submodules = false,
    opts = {},
  },
}
