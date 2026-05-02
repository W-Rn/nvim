-- ==============================================================
-- LSP Saga UI — LspAttach 懒加载（仅当有 LSP 客户端附加时激活）
-- ==============================================================

vim.pack.add({ { src = "https://github.com/nvimdev/lspsaga.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("LspAttach", {
    once = true,
    callback = function()
        vim.cmd.packadd("lspsaga.nvim")
        require("lspsaga").setup({
            ui = {
                code_action = "",
            },
            lightblb = {
                virtual_text = false,
            },
        })
    end,
})
