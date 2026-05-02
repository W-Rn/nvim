-- ==============================================================
-- Git 集成 — gitsigns + lazygit + chezmoi-signs
-- gitsigns/chezmoi: VimEnter 懒加载
-- lazygit: <c-g> 按键懒加载
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },
    { src = "https://github.com/W-Rn/chezmoi-signs.nvim" },
}, { load = function() end, confirm = false })

-- gitsigns — VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("gitsigns.nvim")
        require("gitsigns").setup({
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map("n", "<leader>hQ", function()
                    gitsigns.setqflist("all")
                end)
                map("n", "<leader>hq", gitsigns.setqflist)
            end,
        })
    end,
})

-- lazygit — <c-g> 按键触发
local lazygit_loaded = false
vim.keymap.set("n", "<c-g>", function()
    if not lazygit_loaded then
        lazygit_loaded = true
        vim.cmd.packadd("lazygit.nvim")
        vim.g.lazygit_floating_window_scaling_factor = 1.0
        vim.g.lazygit_floating_window_winblend = 0
        vim.g.lazygit_use_neovim_remote = true
    end
    vim.cmd("LazyGit")
end, { desc = "LazyGit" })

-- chezmoi-signs — VimEnter
vim.api.nvim_create_autocmd("BufReadPost", {
    once = true,
    callback = function()
        vim.cmd.packadd("chezmoi-signs.nvim")
    end,
})
