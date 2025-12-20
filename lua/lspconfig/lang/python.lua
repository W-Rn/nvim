return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python",
    opts = { -- this can be an empty lua table - just showing below for clarity.
      search = {}, -- if you add your own searches, they go here.
      options = {}, -- if you add plugin options, they go here.
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)
      -- stylua: ignore
      vim.keymap.set("n", "<leader>vs", "<Cmd>VenvSelect<CR>", { silent = true, noremap = true, buffer = true, desc = "Select VirtualEnv" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "pyright", "black", "isort" } },
  },
}
