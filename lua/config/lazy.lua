-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup {
  ui = {
    -- 核心样式配置
    border = "rounded", -- 边框样式：rounded（圆角）/ single（单线）/ double（双线）/ none
    title = " Lazy Plugin Manager ", -- 标题文字
    title_pos = "center", -- 标题位置：left/center/right
  },

  spec = {
    {
      "folke/lazydev.nvim",
      enabled = true,
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
          { path = "lazy.nvim", words = { "LazyVim" } },
        },
      },
    },
    -- import your plugins
    --{ import = "plugins" },
    require "ui.include",
    require "plugins.include",
    require "lspconfig.include",
  },

  install = { colorscheme = { "habamax" }, autoUpdate = false, missing = false },
  --install = { colorscheme = { "tokyonight"},},
  -- automatically check for plugin updates
  checker = { enabled = false },
}
