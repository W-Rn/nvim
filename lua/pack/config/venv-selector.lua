-- ==============================================================
-- Python 虚拟环境选择器 — ft=python 懒加载
-- ==============================================================

vim.pack.add(
    { { src = "https://github.com/linux-cultist/venv-selector.nvim" } },
    { load = function() end, confirm = false }
)

vim.api.nvim_create_autocmd("FileType", {
    once = true,
    pattern = "python",
    callback = function()
        vim.cmd.packadd("venv-selector.nvim")
        ---@diagnostic disable: missing-fields
        require("venv-selector").setup({
            options = {
                picker = "snacks",
            },
            search = {
                workspace = {
                    command = "fd '/bin/python$' . -H -E .git --full-path --color never",
                    type = "workspace",
                },
                system_python = {
                    command = "fd '/python3$' /usr/bin/ --full-path --color never",
                    type = "system",
                },
            },
        })

        vim.keymap.set("n", "<leader>vs", "<Cmd>VenvSelect<CR>", { silent = true, desc = "Select VirtualEnv" })
    end,
})
