---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end
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
    "venv",
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
      inlayHints = {
        variableTypes = true, -- 显示变量类型提示
        functionReturnTypes = true, -- 显示函数返回类型提示
        callArgumentNames = true, -- 显示调用参数名提示
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "自动选择 Neovim 打开时的虚拟环境",
      pattern = "*",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          require("venv-selector").retrieve_from_cache()
        end
      end,
      once = true,
    })
    vim.api.nvim_create_user_command("ShowPythonPath", function()
      local python_path = vim.g.python3_host_prog or vim.fn.exepath "python3"
      print("当前 Python 解释器路径: " .. python_path)
    end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
      client:exec_cmd {
        command = "pyright.organizeimports",
        arguments = { vim.uri_from_bufnr(bufnr) },
      }
    end, {
      desc = "Organize Imports",
    })
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
      desc = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    })
  end,
}
