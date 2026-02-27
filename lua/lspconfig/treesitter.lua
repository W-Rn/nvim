return {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    branch = "master",
    lazy = false,
    -- build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
        auto_install = true, -- 自动安装缺失的解析器
        ensure_installed = { "lua", "markdown", "markdown_inline" },
        sync_install = false,
        ignore_install = {}, -- 不需要安装的语法解析器（空列表表示不忽略）
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = function(ft)
                local disabled_fts = { "text" }
                return vim.tbl_contains(disabled_fts, ft)
            end,
        },
        folding = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = false },
    },
    config = function(_, opts)
        local TS = require "nvim-treesitter.configs"
        TS.setup(opts)
    end,
}
