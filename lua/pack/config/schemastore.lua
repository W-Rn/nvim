-- ==============================================================
-- JSON Schema 目录 — 立即加载，无需额外配置
-- ==============================================================

vim.pack.add({ { src = "https://github.com/b0o/schemastore.nvim" } }, { confirm = false })
-- 插件加载后自动提供 JSON schema 补全能力，无需 setup()
