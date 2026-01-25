return {
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      {
        "<leader>cn",
        function()
          require("neogen").generate()
        end,
        desc = "Generate Annotations (Neogen)",
      },
    },
    config = function()
      require("neogen").setup {
        enabled = true,
        languages = {
          lua = {
            template = {
              annotation_convention = "emmylua",
            },
          },
          python = {
            template = {
              annotation_convention = "reST",
            },
          },
        },
      }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("i", "<C-n>", "<cmd>lua require('neogen').jump_next()<CR>", opts)
      vim.api.nvim_set_keymap("i", "<C-p>", "<cmd>lua require('neogen').jump_prev()<CR>", opts)
    end,
  },
}
