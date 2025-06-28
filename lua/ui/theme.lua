return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.surface2 },
          Visual = { bg = colors.overlay0 },
          Search = { bg = colors.surface2 },
          IncSearch = { bg = colors.lavender },
          CurSearch = { bg = colors.lavender },
          MatchParen = { bg = colors.lavender, fg = colors.base, bold = true },
        }
      end,
      integrations = {
        bufferline = true,
        treesitter = true,
        mason = false,
        noice = true,
        neotree = true,
        blink_cmp = true,
        rainbow_delimiters = true,
        which_key = true,
        lsp_saga = true,
        illuminate = true,
        dropbar = true,
        snacks = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
      vim.api.nvim_exec_autocmds("User", {
        pattern = "LoadTheme",
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      -- vim.cmd.colorscheme "tokyonight"
      -- vim.api.nvim_exec_autocmds("User", {
      --   pattern = "LoadTheme",
      -- })
    end,
  },
}
