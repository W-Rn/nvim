return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "bash" } },
    },
    {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "bash-language-server", "shfmt", "shellcheck" } },
    },
}
