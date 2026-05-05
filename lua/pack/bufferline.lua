-- ==============================================================
-- Buffer 标签栏 — 首个文件读取时激活 (BufReadPost)
-- ==============================================================

vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("BufReadPost", {
    once = true,
    callback = function()
        vim.cmd.packadd("bufferline.nvim")
        require("bufferline").setup({
            options = {
                hide_extensions = true,
                show_all_buffers = false,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = " Neo-Tree",
                        text_align = "center",
                        highlight = "Directory",
                        separator = true,
                        padding = 0,
                    },
                    {
                        filetype = "opencode_output",
                        text = "OpenCode",
                        text_align = "center",
                        highlight = "Directory",
                        separator = true,
                        padding = 0,
                    },
                    {
                        filetype = "Outline",
                        text = " Code Outline",
                        text_align = "center",
                        highlight = "Label",
                        separator = true,
                        padding = 0,
                    },
                    {
                        filetype = "nvim-undotree",
                        text = " Undo History",
                        text_align = "center",
                        highlight = "Special",
                        separator = true,
                        padding = 0,
                    },
                },
                tab_size = 10,
            },
            highlights = {
                buffer_selected = {
                    bold = true,
                    italic = false,
                },
            },
        })

        vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", { desc = "BufferLineCycleNext" })
        vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", { desc = "BufferLineCyclePrev" })
        -- vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", { desc = "BufferLine move next" })
        -- vim.keymap.set("n", "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", { desc = "BufferLine move prev" })
        -- vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "BufferLine TogglePin" })
    end,
})
