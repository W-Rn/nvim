-- ==============================================================
-- 代码格式化 — 文件保存前激活 (BufWritePre)
-- ==============================================================

vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("BufReadPost", {
    once = true,
    callback = function()
        vim.cmd.packadd("conform.nvim")
        require("conform").setup({
            formatters = {
                jq = { args = { "--indent", "4" } },
            },
            -- stylua: ignore start
            formatters_by_ft = {
                lua     = { "stylua" },
                python  = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                cpp     = { "clang-format" },
                c       = { "clang-format" },
                json    = { "jq" },
                sh      = { "shfmt" },
            },
            -- stylua: ignore end
            format_on_save = {
                timeout_ms = 5000, -- 格式化超时时间（毫秒）
                lsp_fallback = false, -- 如果格式化失败，尝试使用 LSP 格式化
            },
        })
    end,
})
