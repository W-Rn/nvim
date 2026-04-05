return {
    {
        "linux-cultist/venv-selector.nvim",
        ft = "python",
        opts = {
            search = {
                python = {
                    command = "fd '/python3$' /usr/bin/ --full-path --color never",
                },
            },
            options = {
                picker = "snacks",
                -- enable_default_searches = false,
            },
        },
        config = function(_, opts)
            require("venv-selector").setup(opts)
            -- stylua: ignore
            vim.keymap.set("n", "<leader>vs", "<Cmd>VenvSelect<CR>", { silent = true, noremap = true, buffer = false, desc = "Select VirtualEnv" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "python" } },
    },
    {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "pyright", "ruff", "debugpy" } },
    },
}
