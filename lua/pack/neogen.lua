-- ==============================================================
-- 注释生成器 — LspAttach 懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/danymat/neogen" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("LspAttach", {
    once = true,
    callback = function()
        vim.cmd.packadd("neogen")
        require("neogen").setup({
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
        })

        vim.keymap.set("i", "<C-n>", "<cmd>lua require('neogen').jump_next()<CR>", { desc = "Neogen: Jump next" })
        vim.keymap.set("i", "<C-p>", "<cmd>lua require('neogen').jump_prev()<CR>", { desc = "Neogen: Jump prev" })
        vim.keymap.set("n", "<leader>cn", "<cmd>lua require('neogen').generate()<CR>", { desc = "Neogen: Generate" })
    end,
})
