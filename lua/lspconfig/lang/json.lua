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
        "json-lsp", -- 正确
        "prettierd", -- 正确（推荐用 prettierd 而不是 prettier）
      },
    },
  },
}
