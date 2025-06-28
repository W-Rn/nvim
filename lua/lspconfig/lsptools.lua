return {
  {
    "mason-org/mason.nvim",
    event = { "BufReadPost", "BufNewFile", "VimEnter" },
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    -- "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        auto_install = true, -- 自动安装缺失的解析器
        ensure_installed = { "python", "lua", "c", "cpp", "json", "html", "vim", "markdown", "markdown_inline" }, -- 注意 c++ 的解析器名是 "cpp"
        ignore_install = {}, -- 不需要安装的语法解析器（空列表表示不忽略）
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          -- 添加文件类型白名单
          disable = function(ft)
            local disabled_fts = { "text" }
            return vim.tbl_contains(disabled_fts, ft)
          end,
        },
        folding = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = false,
        },
      }
    end,
  },
}
