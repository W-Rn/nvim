return {
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "lua", "html", "xml", "python", "lua", "kitty", "tmux", "toml", "i3config" },
    opts = {
      user_default_options = {
        names = false,
      },
    },
  },
  {
    "nvzone/showkeys",
    event = "VeryLazy",
    opts = {
      maxkeys = 5,
    },
  },
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
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
