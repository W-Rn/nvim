vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/benomahony/oil-git.nvim" },
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
    vim.cmd.packadd("oil-git.nvim")
    require("oil").setup({
        default_file_explorer = true,
        keymaps = {
            ["<C-r>"] = "actions.refresh",
            ["<leader>y"] = "actions.yank_entry",
            ["g."] = false,
            ["zh"] = "actions.toggle_hidden",
            ["\\"] = { "actions.select", opts = { horizontal = true } },
            ["|"] = { "actions.select", opts = { vertical = true } },
            ["<leader>e"] = "actions.close",
            ["<BS>"] = "actions.parent",
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
        },
        win_options = {
            winbar = "%!v:lua.get_oil_winbar()",
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
