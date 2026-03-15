return {
    -- "stevearc/conform.nvim",
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        config = function()
            require("conform").setup {
                formatters = {
                    jq = { args = { "--indent", "4" } },
                },
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                    json = { "jq" },
                    sh = { "shfmt" },
                },
                format_on_save = {
                    timeout_ms = 5000, -- 格式化超时时间（毫秒）
                    lsp_fallback = false, -- 如果格式化失败，尝试使用 LSP 格式化
                },
            }
        end,
    },
}
