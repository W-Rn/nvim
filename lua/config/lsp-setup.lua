-- 启用 LSP 和内置补全
vim.lsp.enable "lua_ls"
vim.lsp.enable "clangd"
vim.lsp.enable "pyright"

vim.diagnostic.config {
  update_in_insert = false,
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
  float = {
    border = "single",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
}
local hover = function()
  vim.lsp.buf.hover {
    border = "single",
    max_width = 100,
  }
end
local signature_help = function()
  vim.lsp.buf.signature_help {
    border = "single",
    max_width = 100,
    title_pos = "left",
  }
end

-- local snacks = require "snacks"
-- 设置 LSP 快捷键
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_user_command("LspRootDir", function()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      for _, client in ipairs(clients) do
        local root = nil
        if client.config and client.config.root_dir then
          if type(client.config.root_dir) == "function" then
            root = client.config.root_dir(vim.api.nvim_buf_get_name(0))
          else
            root = client.config.root_dir
          end
        end
        if not root then
          root = vim.fn.getcwd()
        end
        print(client.name .. ": " .. (root or "N/A"))
      end
    end, {})

    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- 通用 LSP 快捷键
    local keymap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc, silent = true, noremap = true })
    end
    -- 绑定快捷键LSP
    -- -- LSP跳转
    -- keymap(, "<leader>gd", vim.lsp.buf.definition, "LSP :Definition")
    -- keymap("n", "<leader>go", vim.lsp.buf.type_definition, "LSP : Type Definition")
    -- keymap("n", "<leader>gD", vim.lsp.buf.declaration, "LSP :Declaration")
    -- keymap("n", "<leader>gi", vim.lsp.buf.implementation, "LSP :Implementation")
    -- keymap("n", "<leader>gr", vim.lsp.buf.references, "LSP :References")
    --
    -- keymap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "LSP :Code Action")
    keymap("n", "<leader>d", vim.diagnostic.open_float, "LSP : Diagnostic Float")

    -- 自定义样式
    -- 绑定快捷键自定义函数签名和悬浮文档
    keymap("n", "<leader>gk", hover, "LSP : Hover")
    keymap({ "n", "i" }, "<C-s>", signature_help, "LSP :Signature Help")
    keymap("n", "<leader>rn", vim.lsp.buf.rename, "LSP :Rename")
    -- stylua: ignore
    keymap("n", "<leader>gd", Snacks.picker.lsp_definitions, "Goto Definition" )
    keymap("n", "<leader>gD", Snacks.picker.lsp_declarations, "Goto Declaration")
    keymap("n", "<leader>gr", Snacks.picker.lsp_references, "References")
    keymap("n", "<leader>gi", Snacks.picker.lsp_implementations, "Goto Implementation")
    keymap("n", "<leader>go", Snacks.picker.lsp_type_definitions, "Goto T[y]pe Definition")
    keymap("n", "<leader>gs", Snacks.picker.lsp_symbols, "LSP Symbols")
    keymap("n", "<leader>gS", Snacks.picker.lsp_workspace_symbols, "LSP Workspace Symbols")

    -- Python 专用快捷键 (Pyright)
    -- if client and client.name == "pyright" then
    --   keymap("n", "<leader>gr", vim.lsp.buf.references, "LSP :References")
    -- end
  end,
})
