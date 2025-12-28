return {
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
          -- type = "split",
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
}
