-- ==============================================================
-- 主题 — 立即加载，尽早设定 colorscheme
-- ==============================================================

vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }, { confirm = false })

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        bufferline = true,
        treesitter = true,
        mason = false,
        neotree = true,
        blink_cmp = true,
        rainbow_delimiters = true,
        which_key = true,
        lsp_saga = true,
        illuminate = true,
        snacks = true,
        flash = true,
    },
})

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#4682B4" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none", fg = "#FCA561" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#4682B4" })
vim.api.nvim_set_hl(0, "Visual", { reverse = true })
