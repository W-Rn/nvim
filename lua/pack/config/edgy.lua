-- ==============================================================
-- 窗口布局管理 — VimEnter 懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/folke/edgy.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("edgy.nvim")
        vim.opt.splitkeep = "screen"

        require("edgy").setup({
            animate = { enabled = false },
            options = {
                left = { size = 50 },
                right = { size = 50 },
                top = { size = 10 },
                bottom = { size = 15 },
            },
            bottom = {
                {
                    title = "Terminal",
                    ft = "toggleterm",
                    pinned = false,
                    open = function()
                        require("toggleterm").toggle()
                    end,
                    wo = { winbar = true },
                },
                {
                    ft = "qf",
                    title = function()
                        local qf_info = vim.fn.getqflist({ title = 0 })
                        local qf_title = qf_info.title or ""
                        if qf_title:lower():find("git") or qf_title:lower():find("hunk") then
                            return " Gitsigns"
                        elseif qf_title:lower():find("diagnostics") or qf_title == "" or qf_title == "Quickfix" then
                            return " Diagnostics"
                        end
                        return qf_title
                    end,
                    pinned = false,
                    wo = { winbar = true },
                },
            },
            left = {
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    pinned = false,
                    open = "NeoTree",
                    wo = { winbar = false },
                },
                {
                    title = "Undo-Tree",
                    ft = "nvim-undotree",
                    pinned = false,
                    wo = { winbar = false },
                },
            },
            right = {
                {
                    title = "Outline",
                    ft = "Outline",
                    pinned = true,
                    open = "Outline",
                    wo = { winbar = false },
                },
            },
            icons = {
                closed = " ",
                open = " ",
            },
        })
    end,
})
