---@type vim.lsp.Config
return {
  cmd = { "bash-language-server", "start" },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command|.zsh)",
    },
  },
  filetypes = { "sh", "zsh", "bash" },
  root_markers = { ".git" },
}
