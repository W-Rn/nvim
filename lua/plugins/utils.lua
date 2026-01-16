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
    cmd = "ShowkeysToggle",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LoadTheme",
        callback = function()
          vim.api.nvim_set_hl(0, "ShowkeysBorder", { fg = "#80A0FF", bg = "none" })
          vim.api.nvim_set_hl(0, "showkeysNormal", { fg = "none", bg = "none" })
          vim.api.nvim_set_hl(0, "SkInactive", { fg = "#7F848E", bg = "none" })
          vim.api.nvim_set_hl(0, "SkActive", { fg = "#FFFFFF", bg = "none" })
        end,
      })
    end,
    opts = {
      maxkeys = 5,
      winopts = {
        border = "rounded",
      },
      winhl = "FloatBorder:ShowkeysBorder,Normal:showkeysNormal",
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
