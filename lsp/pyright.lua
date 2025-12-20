return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
    "main.py",
    ".venv",
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- 可选: "off", "basic", "strict"
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly", -- 或 "openFilesOnly"
        useLibraryCodeForTypes = true,
        autoImportCompletions = true, -- 启用自动导入补全
      },
    },
  },
  on_attach = function(_, _)
    vim.api.nvim_create_user_command("ShowPythonPath", function()
      local python_path = vim.g.python3_host_prog or vim.fn.exepath "python3"
      print("当前 Python 解释器路径: " .. python_path)
    end, {})
  end,
}
