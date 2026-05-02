-- ==============================================================
-- 代码格式化 — 文件保存前激活 (BufWritePre)
-- ==============================================================

vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("BufWritePre", {
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
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 5000, lsp_format = "fallback" }
            end,
        })
    end,
})
