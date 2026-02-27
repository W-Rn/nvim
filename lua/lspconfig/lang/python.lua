return {
    {
        "linux-cultist/venv-selector.nvim",
        ft = "python",
        opts = {
            search = {
                python = {
                    command = "$FD '/python3$' /usr/bin/ --full-path --color never",
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
      vim.keymap.set("n", "<leader>vs", "<Cmd>VenvSelect<CR>", { silent = true, noremap = true, buffer = true, desc = "Select VirtualEnv" })
            -- vim.keymap.set("n", "<leader>vp", function()
            --   local python = require("venv-selector").python()
            --   if python then
            --     print("Current Python: " .. python)
            --   else
            --     print "No virtual environment selected"
            --     vim.cmd "VenvSelect"
            --   end
            -- end, { desc = "Show current Python or select venv" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "python" } },
    },
    {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "pyright", "black", "isort" } },
    },
}
