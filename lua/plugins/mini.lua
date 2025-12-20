return {
  {
    "echasnovski/mini.files",
    version = "*",
    keys = "<leader>mf",
    config = function()
      require("mini.files").setup {
        mappings = {
          close = "Q",
          go_in = "l",
          go_in_plus = "L",
          go_out = "h",
          go_out_plus = "H",
          mark_goto = "'",
          mark_set = "m",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "<CR>",
        },

        options = {
          permanent_delete = true,
          use_as_default_explorer = true,
        },
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 20,
          width_nofocus = 20,
          width_preview = 90,
        },
      }
      -- stylua: ignore
      vim.keymap.set("n", "<leader>mf", require("mini.files").open,{silent = true, noremap = true, buffer = true, desc = "Open MiniFiles"})
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    config = true,
    keys = {
      { "s", "<NOP>", mode = { "n", "x", "o" } },
    },
  },

  {
    "echasnovski/mini.ai",
    version = "*",
    -- event = "BufReadPost",
    event = "VeryLazy",
    config = true,
  },

  {
    "nvim-mini/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>md",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    },
  },
}
