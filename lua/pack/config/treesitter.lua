-- ==============================================================
-- 语法高亮 — 立即加载，按文件类型启用 treesitter
-- ==============================================================

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } }, { confirm = false })

local ensure_installed = {
    "python",
    "bash",
    "json",
    "cpp",
    "rust",
}

require("nvim-treesitter").setup()
require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "sh", "zsh", "json", "jsonc", "c", "cpp", "rust" },
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
