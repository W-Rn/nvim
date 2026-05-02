-- ==============================================================
-- 按键提示 — VimEnter 懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("which-key.nvim")
        require("which-key").setup({
            preset = "modern",
            win = {
                title = true,
                width = 0.5,
            },
            spec = {
                { "<leader>n", group = "<Noice>" },
                { "<leader>t", group = "<telescope>" },
                { "<leader>b", group = "<BuffeeLine>" },
                { "z", group = "<fold>" },
                { "<leader>a", group = "<opencode>" },
            },
            expand = function(node)
                return not node.desc
            end,
        })

        vim.keymap.set("n", "<leader>?", function()
            require("which-key").show({ global = false })
        end, { desc = "[Which-key] Buffer Local Keymaps" })
    end,
})
