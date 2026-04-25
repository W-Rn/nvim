return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            local gitsigns = require "gitsigns"
            gitsigns.setup {
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "▎" },
                    untracked = { text = "▎" },
                },
                signs_staged = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "▎" },
                },
                on_attach = function(bufnr)
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    map("n", "<leader>hQ", function()
                        gitsigns.setqflist "all"
                    end)
                    map("n", "<leader>hq", gitsigns.setqflist)
                end,
            }
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        keys = { "<c-g>" },
        config = function()
            vim.g.lazygit_floating_window_scaling_factor = 1.0
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_use_neovim_remote = true
            vim.keymap.set("n", "<c-g>", ":LazyGit<CR>", { noremap = true, silent = true })
        end,
    },
    {
        "W-Rn/chezmoi-signs.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
