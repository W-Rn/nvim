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
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = true,
          -- Whether to use for editing directories
          use_as_default_explorer = true,
        },

        -- Customization of explorer windows
        windows = {
          -- Maximum number of windows to show side by side
          max_number = math.huge,
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 20,
          -- Width of non-focused window
          width_nofocus = 20,
          -- Width of preview window
          width_preview = 90,
        },
      }
      vim.keymap.set("n", "<leader>mf", require("mini.files").open)
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    -- event = "BufReadPost",
    event = "VeryLazy",
    config = true,
    keys = {
      -- Disable the vanilla `s` keybinding
      { "s", "<NOP>", mode = { "n", "x", "o" } },
    },
  },

  {
    -- Extend `a`/`i` textobjects
    "echasnovski/mini.ai",
    version = "*",
    -- event = "BufReadPost",
    event = "VeryLazy",
    config = true,
  },

  -- {
  --   "echasnovski/mini.diff",
  --   event = "VeryLazy",
  --   version = "*",
  --   opts = {},
  -- },
}
