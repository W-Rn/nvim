return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    -- cmd = "Lspsaga",
    -- keys = {
    --   { "<leader>gc", "<Cmd>Lspsaga code_action<CR>", desc = "code action", silent = true },
    -- },
    opts = {
        ui = {
            code_action = "",
        },
        lightblb = {
            virtual_text = false,
        },
    },
}
