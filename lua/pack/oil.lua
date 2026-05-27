vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/W-Rn/oil-git-signs.nvim" },
}, { load = function() end, confirm = false })

function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        return vim.api.nvim_buf_get_name(0)
    end
end

local oil_loaded = false
local function ensure_oil()
    if oil_loaded then
        return
    end
    local detail = false
    oil_loaded = true
    vim.cmd.packadd("oil.nvim")
    vim.cmd.packadd("oil-git-signs.nvim")
    require("oil").setup({
        default_file_explorer = true,
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<C-r>"] = "actions.refresh",
            ["<C-p>"] = "actions.preview",
            ["<CR>"] = "actions.select",
            ["\\"] = { "actions.select", opts = { horizontal = true } },
            ["|"] = { "actions.select", opts = { vertical = true } },
            ["."] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["g."] = { "actions.open_cwd", mode = "n" },
            ["<BS>"] = "actions.parent",
            ["<leader>e"] = "actions.close",
            ["q"] = "actions.close",
            ["H"] = { "actions.toggle_hidden", mode = "n" },
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    detail = not detail
                    if detail then
                        require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                    else
                        require("oil").set_columns({ "icon" })
                    end
                end,
            },

            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        use_default_keymaps = false,
        win_options = {
            winbar = "%!v:lua.get_oil_winbar()",
            signcolumn = "yes:2",
        },
        float = {
            border = "rounded",
        },
        confirmation = {
            border = "rounded",
        },
        progress = {
            border = "rounded",
        },
        keymaps_help = {
            border = "rounded",
        },
    })
end
vim.keymap.set("n", "<leader>e", function()
    ensure_oil()
    vim.cmd("Oil")
end, { desc = "Oil File" })

vim.api.nvim_create_autocmd("User", {
    pattern = "LoadDirectory",
    once = true,
    callback = function()
        ensure_oil()
    end,
})
