return {
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    keys = {
      { ":" },
      { "?" },
      { "/" },
      { "<leader>na", "<CMD>NoiceAll<CR>", desc = "[Noice] Show All messages" },
      { "<leader>ne", "<CMD>NoiceError<CR>", desc = "[Noice] Show Error messages" },
      -- { "<leader>nl", "<CMD>NoiceLast<CR>", desc = "[Noice] Show Last messages" },
      -- { "<leader>nh", "<CMD>NoiceHistory<CR>", desc = "[Noice] Show History messages" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LoadTheme",
        callback = function()
          vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#4682B4" })
        end,
      })
    end,
    opts = {
      views = {
        popup = {
          border = {
            style = "rounded",
          },
          size = {
            width = "80%",
            height = "80%",
          },
        },
      },
      health = {
        checker = false,
      },
      lsp = {
        progress = { enabled = false },
        hover = { enabled = true, opts = { scrollbar = false } },
        signature = {
          enabled = true,
          auto_open = {
            enabled = false,
          },
          opts = { scrollbar = false },
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = "rounded", -- add a border to hover docs and signature help
      },
      commands = {
        history = {
          view = "popup",
        },
        all = {
          view = "popup",
        },
      },
      config = function(_, opts)
        require("noice").setup(opts)
      end,
    },
  },
}
