return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "folke/snacks.nvim",
      "mfussenegger/nvim-dap-python",
    },
    ft = "python",
    cmd = "VenvSelect",
    opts = {
      -- 其他选项
      name = { "venv", ".venv" },
      auto_refresh = true,
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        -- stylua: ignore
        callback = function()
          vim.keymap.set("n", "<leader>vs", "<Cmd>VenvSelect<CR>", { silent = true, noremap = true, buffer = true, desc = "Select VirtualEnv" })
        end,
      })
    end,
  },
}
