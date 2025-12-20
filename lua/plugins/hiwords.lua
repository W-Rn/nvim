return {
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure {
        delay = 0, -- 高亮延迟 (ms)
        under_cursor = false, -- 光标下单词高亮 (避免与光标样式冲突)
        providers = { -- 支持的后端
          "lsp",
          "treesitter",
        },
        filetypes_denylist = { -- 禁用文件类型
          "NeoTree",
        },
        modes_denylist = { "i", "v" }, -- 禁用模式
      }
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IncSearch" })
    end,
  },
}
