-- ==============================================================
-- LSP 工具安装器 — VimEnter 懒加载（安装后启用 LSP 服务器）
-- LSP Saga       — LspAttach 懒加载（仅当有 LSP 客户端附加时激活）
-- glance         — LspAttach 懒加载（仅当有 LSP 客户端附加时激活）
-- ==============================================================

vim.pack.add({
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/DNLHC/glance.nvim" },
    { src = "https://github.com/nvimdev/lspsaga.nvim" },
}, { load = function() end, confirm = false })

-- mason
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("mason.nvim")
        require("mason").setup({
            ui = { border = "rounded" },
        })

        -- stylua: ignore start
        local ensure_installed = {
            "bash-language-server",     "shfmt",            "shellcheck",
            "pyright",                  "ruff",             "debugpy",
            "lua-language-server",      "stylua",
            "clangd",                   "clang-format",
            "json-lsp",                 "jq",
        }
        -- stylua: ignore end

        local mr = require("mason-registry")
        local function do_install()
            for _, tool in ipairs(ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end

        if mr.refresh then
            mr.refresh(do_install)
        else
            do_install()
        end

        -- 启用所有已配置的 LSP 服务器
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("bashls")
        vim.lsp.enable("clangd")
        vim.lsp.enable("jsonls")
    end,
})
-- glance
local glance_loaded = false
local function ensure_glance()
    if glance_loaded then
        return
    end
    glance_loaded = true
    vim.cmd.packadd("glance.nvim")
    local glance = require("glance")
    local actions = glance.actions
    ---@diagnostic disable-next-line: missing-fields
    glance.setup({
        height = 30,
        mappings = {
            list = {
                ["<leader>l"] = false, -- Focus preview window
                ["<leader>h"] = actions.enter_win("preview"), -- Focus preview window
                ["<Esc>"] = false, -- Disable a mapping
            },
            preview = {
                ["q"] = actions.close,
            },
        },
    })
end

-- lspsaga
local lspsaga_loaded = false
local function ensure_lspsaga()
    if lspsaga_loaded then
        return
    end
    lspsaga_loaded = true
    vim.cmd.packadd("lspsaga.nvim")
    require("lspsaga").setup({
        ui = {
            code_action = "",
        },
        lightblb = {
            virtual_text = false,
        },
    })
end

vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = { spacing = 2, prefix = "●" },
    severity_sort = true,
    float = {
        border = "rounded",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})

-- 诊断变化时自动刷新 quickfix 列表
local qf_refresh_timer = nil
vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        if qf_refresh_timer then
            vim.fn.timer_stop(qf_refresh_timer)
        end
        qf_refresh_timer = vim.fn.timer_start(100, function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "quickfix" then
                    vim.diagnostic.setqflist()
                    break
                end
            end
        end)
    end,
    desc = "诊断变化时刷新 quickfix",
})

-- 设置 LSP 快捷键
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(args)
        ensure_lspsaga()
        ensure_glance()
        -- 通用 LSP 快捷键
        local keymap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc, silent = true, noremap = true })
        end
        -- stylua: ignore start
        keymap("n", "grq", vim.diagnostic.setqflist, "诊断到 quickfix")
        keymap("n", "[d", function() vim.diagnostic.jump { count = -1 } end, "上一个诊断")
        keymap("n", "]d", function() vim.diagnostic.jump { count = 1 } end, "下一个诊断")
        keymap("n", "[e", function() vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR } end, "上一个错误")
        keymap("n", "]e", function() vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR } end, "下一个错误")
        keymap("n", "<leader>d", vim.diagnostic.open_float, "LSP : Diagnostic Float")
        keymap("n", "<leader>gk", vim.lsp.buf.hover, "LSP : Hover")
        keymap("n", "<leader>rn", vim.lsp.buf.rename, "LSP :Rename")
        keymap("n", "<leader>gd", "<CMD>Glance definitions<CR>", "Lsp definitions")
        keymap("n", "<leader>gr", "<CMD>Glance references<CR>", "Lsp References")
        keymap("n", "<leader>gt", "<CMD>Glance type_definitions<CR>", "lsp Type_Definitions")
        keymap("n", "<leader>gi", "<CMD>Glance implementations<CR>", "Lsp Implementations")
        keymap({ "n", "x" }, "<leader>ga", vim.lsp.buf.code_action, "LSP :Code Action")
        keymap({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, "LSP :Signature Help")
        -- stylua: ignore end
    end,
})
