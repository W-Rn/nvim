local M = {}
function M.setup()
  local opts = {
    options = {
      theme = "catppuccin",
      component_separators = "",
    },
    sections = {
      lualine_c = { "" },
      lualine_x = { "lsp_status" },
      -- lualine_y = { "encoding", "fileformat", "filetype", "progress" },
      lualine_y = { "filetype", "progress" },
    },
  }
  local mocha = require("catppuccin.palettes").get_palette "mocha"
  local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    else
      return "󰑋 " .. recording_register
    end
  end

  local macro_recording = {
    show_macro_recording,
    color = { fg = "#333333", bg = mocha.red },
    separator = { left = "", right = "" },
    padding = 0,
  }
  local function lsp_root_component()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    local root = nil
    for _, client in ipairs(clients) do
      if client.config and client.config.root_dir then
        root = client.config.root_dir
        break
      end
    end
    if not root then
      root = vim.fn.getcwd()
    end
    return " " .. vim.fn.fnamemodify(root, ":t")
  end

  -- local function venv_dir()
  --   local venv = require("venv-selector").venv()
  --   if venv then
  --     return "🐍 " .. vim.fn.fnamemodify(venv, ":t")
  --   end
  --   return ""
  -- end
  --
  -- table.insert(opts.sections.lualine_c, 2, venv_dir)
  table.insert(opts.sections.lualine_c, 1, lsp_root_component)
  table.insert(opts.sections.lualine_x, 1, macro_recording)
  require("lualine").setup(opts)
end
return M
