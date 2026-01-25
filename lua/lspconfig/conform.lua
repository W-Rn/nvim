return {
  -- "stevearc/conform.nvim",
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- 按需加载
    config = function()
      require("conform").setup {
        -- 定义不同文件类型的格式化工具
        formatters_by_ft = {
          lua = { "stylua" }, -- Lua 使用 stylua
          python = { "isort", "black" },
          cpp = { "clang-format" },
          c = { "clang-format" },
          json = { "prettierd" },
          sh = { "shfmt" },
        },
        -- 设置保存文件时自动格式化
        format_on_save = {
          timeout_ms = 5000, -- 格式化超时时间（毫秒）
          lsp_fallback = false, -- 如果格式化失败，尝试使用 LSP 格式化
        },
      }
    end,
  },
}
