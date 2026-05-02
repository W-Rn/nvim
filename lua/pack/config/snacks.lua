-- ==============================================================
-- Snacks 工具集 — 立即加载（状态列/缩进线/仪表盘/终端/picker/通知）
-- ==============================================================

vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } }, { confirm = false })

vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#313244" })

require("snacks").setup({

    words = { enabled = false },
    explorer = { enabled = false },
    bigfile = { enabled = true, size = 3000 * 1024, line_length = 100 },
    dashboard = {
        enabled = true,
        preset = {
            keys = {
                -- stylua: ignore start
                { icon = "󰈞 ", key = "f", desc = "Find files", action = ":lua Snacks.picker.smart()" },
                { icon = " ", key = "n", desc = "New file", action = ":enew" },
                { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                -- stylua: ignore end
            },
        },
        sections = {
            { section = "header", gap = 2 },
            { section = "keys", indent = 0, gap = 2, padding = 5 },
            function()
                local elapsed = vim.g.startuptime_final and vim.g.startuptime_final - vim.g.startuptime
                    or vim.uv.hrtime() - vim.g.startuptime
                local ms = math.floor(elapsed / 1e6 + 0.5)
                return {
                    align = "center",
                    text = {
                        { "⚡ Neovim 启动耗时 ", hl = "SnacksDashboardFooter" },
                        { ms .. "ms", hl = "SnacksDashboardSpecial" },
                    },
                }
            end,
        },
    },
    terminal = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    indent = {
        enabled = true,
        indent = {
            char = "┊",
            only_scope = false,
            only_current = false,
            hl = {
                "SnacksIndent1",
                "SnacksIndent2",
                "SnacksIndent3",
                "SnacksIndent4",
                "SnacksIndent5",
                "SnacksIndent6",
                "SnacksIndent7",
                "SnacksIndent8",
            },
        },
        scope = {
            enabled = true,
            priority = 200,
            char = "│",
            underline = false,
            only_current = false,
            hl = {
                "SnacksIndent1",
                "SnacksIndent2",
                "SnacksIndent3",
                "SnacksIndent4",
                "SnacksIndent5",
                "SnacksIndent6",
                "SnacksIndent7",
                "SnacksIndent8",
            },
        },
    },
    picker = {
        enabled = true,
        layout = { preset = "default" },
        layouts = {
            default = { layout = { width = 0.9, height = 0.9 } },
            select = { layout = { width = 0.6, height = 0.6 } },
        },
        win = {
            preview = {
                wo = {
                    cursorline = true,
                    number = true,
                    relativenumber = true,
                    signcolumn = "no",
                    spell = false,
                    winbar = "",
                    statuscolumn = "",
                    wrap = false,
                    sidescrolloff = 5,
                },
            },
        },
    },
    statuscolumn = {
        left = { "sign", "mark", "git" },
        right = { "fold" },
        folds = { open = true, git_hl = false },
    },
    styles = {
        notification_history = { border = "rounded", width = 0.8, height = 0.8, minimal = true },
        input = { title_pos = "left", height = 1, width = 50, relative = "cursor", row = -3, col = 0 },
        terminal = {
            relative = "editor",
            border = "rounded",
            position = "float",
            backdrop = 60,
            height = 0.9,
            width = 0.8,
            zindex = 50,
        },
        scratch = { border = "rounded", width = 0.8, height = 0.8, minimal = false },
    },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "[Snacks] Smart Find Files" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "[Snacks] Delete Buffer" })
vim.keymap.set("n", "<leader>bD", function() Snacks.bufdelete.other() end, { desc = "[Snacks] Delete Other Buffers" })
vim.keymap.set("n", "<leader>nh", function() Snacks.notifier.show_history() end, { desc = "[Snacks] Notification history" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "[Snacks] Find Buffers" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end, { desc = "[Snacks] Find Config" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "[Snacks] Find Files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "[Snacks] Projects" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "[Snacks] Recent" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep_buffers() end, { desc = "[Snacks] Grep Buffers" })
vim.keymap.set("n", "<leader>fG", function() Snacks.picker.grep() end, { desc = "[Snacks] Grep" })
vim.keymap.set({ "n", "x" }, "<leader>fw", function() Snacks.picker.grep_word() end, { desc = "[Snacks] Grep Word" })
vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "[Snacks] Autocmds" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help { layout = "select" } end, { desc = "[Snacks] Help" })
vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "[Snacks] Highlights" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "[Snacks] Marks" })
vim.keymap.set("n", "<leader>sp", function() Snacks.picker.spelling { layout = "select" } end, { desc = "[Snacks] Spelling" })
vim.keymap.set({ "n", "t" }, "<A-i>", function() Snacks.terminal() end, { desc = "[Snacks] Toggle terminal" })
-- stylua: ignore end

-- LSP 进度通知
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]
        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end
        local msg = {}
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and "●"
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.g.startuptime_final = vim.uv.hrtime()
        pcall(Snacks.dashboard.update)
    end,
})
