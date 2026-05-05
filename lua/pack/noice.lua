-- ==============================================================
-- 消息 UI 增强 — VimEnter 懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/folke/noice.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.o.cmdheight = 0
        vim.cmd.packadd("noice.nvim")
        vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#4682B4" })
        require("noice").setup({
            views = {
                popup = {
                    border = { style = "rounded" },
                    size = { width = "80%", height = "80%" },
                },
            },
            health = { checker = false },
            lsp = {
                progress = { enabled = false },
                hover = { enabled = true, opts = { scrollbar = false } },
                signature = {
                    enabled = true,
                    auto_open = { enabled = false },
                    opts = { scrollbar = false },
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = "rounded",
            },
            commands = {
                history = { view = "popup" },
                all = { view = "popup" },
            },
        })

        vim.keymap.set("n", "<leader>na", "<Cmd>NoiceAll<CR>", { desc = "[Noice] Show All messages" })
        vim.keymap.set("n", "<leader>ne", "<Cmd>NoiceError<CR>", { desc = "[Noice] Show Error messages" })
    end,
})
