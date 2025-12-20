return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cpp" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "clangd", "clang-format" } },
  },
}
