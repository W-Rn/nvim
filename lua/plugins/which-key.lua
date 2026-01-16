return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "modern",
    win = {
      -- no_overlap = true,
      title = true,
      width = 0.5,
    },
      -- stylua: ignore
      spec = {
        { "<leader>n",  group = "<Noice>"                     },
        { "<leader>t",  group = "<telescope>"                 },
        { "<leader>b",  group = "<BuffeeLine>"                },
        { "z",          group = "<fold>"                      },
        { "<leader>cc", group = "<codecompanion>"             },
      },
    -- expand all nodes wighout a description
    expand = function(node)
      return not node.desc
    end,
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "[Which-key] Buffer Local Keymaps",
    },
  },
}
