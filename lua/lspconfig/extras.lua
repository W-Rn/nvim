return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>gt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
    opts = {
      focus = true,
      modes = {
        diagnostics = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.4,
          },
          win = {
            type = "split", -- 可以是 "split" 或 "float"
            relative = "win",
            position = "bottom",
            size = 10,
          },
        },
      },
      keys = {
        ["}"] = false,
        ["]]"] = false,
        ["{"] = false,
        ["[["] = false,
        o = "jump_close",
        ["<cr>"] = "jump",
        ["<2-leftmouse>"] = "jump",
        ["<c-s>"] = "jump_split_close",
        ["<c-v>"] = "jump_vsplit_close",
        j = "next",
        k = "prev",
      },
    },
  },

  {
    "folke/lazydev.nvim",
    enabled = true,
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    cmd = "Lspsaga",
    keys = {
      { "<leader>gc", "<Cmd>Lspsaga code_action<CR>", desc = "code action", silent = true },
    },
    opts = {
      ui = {
        code_action = "",
      },
      lightbulb = {
        virtual_text = false,
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Outline" },
    },
    opts = {},
  },
}
