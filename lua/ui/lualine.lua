return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- event = "VeryLazy",
  event = "VimEnter",
  config = function()
    require("ui/lualine/eveline").setup()
    -- require("ui/lualine/modern").setup()
  end,
}
