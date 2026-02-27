return {
    {
        "danymat/neogen",
        cmd = "Neogen",
        event = "LspAttach",
        config = function()
            require("neogen").setup {
                enabled = true,
                languages = {
                    lua = {
                        template = {
                            annotation_convention = "emmylua",
                        },
                    },
                    python = {
                        template = {
                            annotation_convention = "reST",
                        },
                    },
                },
            }
            local function keymap(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    noremap = true,
                    silent = true,
                    desc = desc,
                })
            end

            keymap("i", "<C-n>", "<cmd>lua require('neogen').jump_next()<CR>", "Neogen: Jump to next placeholder")
            keymap("i", "<C-p>", "<cmd>lua require('neogen').jump_prev()<CR>", "Neogen: Jump to previous placeholder")
            keymap("n", "<leader>cn", "<cmd>lua require('neogen').generate()<CR>", "Neogen: Generate documentation")
        end,
    },
}
