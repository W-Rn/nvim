-- ==============================================================
-- AI 助手 (opencode.nvim) — VimEnter 懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/sudo-tee/opencode.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("opencode.nvim")
        require("opencode").setup({
            keymap_prefix = "<leader>o",
            keymap = {
                input_window = {
                    ["<M-m>"] = { "toggle_pane", mode = { "n", "i" }, defer_to_completion = true },
                    ["<tab>"] = { "switch_mode", mode = { "n" } },
                },
                output_window = {
                    ["<tab>"] = false,
                    ["<M-m>"] = { "toggle_pane", mode = { "n", "i" } },
                },
                session_picker = {
                    rename_session = { "<C-r>", mode = "n" },
                    delete_session = { "<C-d>", mode = "n" },
                    new_session = { "<C-s>", mode = "n" },
                },
            },
        })
    end,
})
