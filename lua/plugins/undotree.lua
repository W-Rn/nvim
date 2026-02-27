return {
    "mbbill/undotree",
    lazy = true,
    cmd = "UndotreeToggle",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo-tree" },
    },
    init = function()
        vim.g.undotree_DiffAutoOpen = 0
        vim.cmd [[
            if has("persistent_undo")
                let target_path = expand('~/.undodir')
                if !isdirectory(target_path)
                    call mkdir(target_path, "p", 0700)
                endif
                let &undodir=target_path
                set undofile
            endif
        ]]
    end,
}
