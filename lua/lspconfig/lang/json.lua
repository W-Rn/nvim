return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json" } },
  },
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "json-lsp",
        "prettierd",
      },
    },
  },
}
