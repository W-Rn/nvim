return {
  -- "zbirenbaum/copilot.lua",
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "VeryLazy",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --     },
  --   },
  -- },

  -- "olimorris/codecompanion.nvim",
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
    },
    -- stylua: ignore
    keys = {
      {"<leader>cca", "<CMD>CodeCompanionActions<CR>",     mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion actions"      },
      {"<leader>cci", "<CMD>CodeCompanion<CR>",            mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion inline"       },
      {"<leader>ccc", "<CMD>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion chat (toggle)"},
      {"<leader>ccp", "<CMD>CodeCompanionChat Add<CR>",    mode = {"v"}     , noremap = true, silent = true, desc = "CodeCompanion chat add code"},
    },

    opts = {
      display = {
        diff = {
          enabled = true,
          provider = "mini_diff",
        },
      },

      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },

      opts = {
        language = "Chinese", -- "English"|"Chinese"
      },
    },
    -- config = function(_, opts)
    --   require("codecompanion").setup(opts)
    --   vim.opt_local.number = false -- 关闭行号
    --   vim.opt_local.relativenumber = false -- 关闭相对行号
    --   -- -- 在 init.lua 或插件配置中添加
    --   -- vim.api.nvim_create_autocmd("FileType", {
    --   --   pattern = "codecompanion", -- 针对插件窗口类型
    --   --   callback = function()
    --   --   end,
    --   -- })
    -- end,
  },
}
