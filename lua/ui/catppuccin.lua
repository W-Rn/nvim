return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            custom_highlights = function(colors)
                return {
                    LineNr = { fg = colors.surface2 },
                    Visual = { bg = colors.overlay0 },
                    Search = { bg = colors.surface2 },
                    IncSearch = { bg = colors.lavender },
                    CurSearch = { bg = colors.lavender },
                    MatchParen = { bg = colors.lavender, fg = colors.base, bold = true },
                }
            end,
            integrations = {
                bufferline = true,
                treesitter = true,
                mason = false,
                noice = true,
                neotree = true,
                blink_cmp = true,
                rainbow_delimiters = true,
                which_key = true,
                lsp_saga = true,
                illuminate = true,
                snacks = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme "catppuccin"
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#00BFFF" })
            vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none", fg = "#FCA561" })
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#00BFFF" })
            vim.api.nvim_exec_autocmds("User", {
                pattern = "LoadTheme",
            })
        end,
    },
}
