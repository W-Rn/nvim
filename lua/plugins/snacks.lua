---@diagnostic disable: missing-fields, undefined-field
return {
    "folke/snacks.nvim",
    -- event = "VeryLazy",
    priority = 1000,
    enabled = true,
    lazy = false,
    init = function()
        -- vim.g.snacks_animate = false
        vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#313244" })
    end,
    ---@type snacks.Config
    opts = {
        words = { enabled = false },
        explorer = { enabled = false },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        terminal = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        indent = {
            enabled = true,
            -- chars = { "│", "¦", "┆", "┊" },
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
                enabled = true, -- enable highlighting the current scope
                priority = 200,
                char = "│",
                underline = false, -- underline the start of the scope
                only_current = false, -- only show scope in the current window
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
            layout = {
                preset = "default",
            },
            layouts = {

                default = {
                    layout = { width = 0.9, height = 0.9 },
                },
                select = {
                    layout = {
                        width = 0.6,
                        height = 0.6,
                    },
                },
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
            left = { "sign", "mark", "git" }, -- priority of signs on the left (high to low)
            right = { "fold" }, -- priority of signs on the right (high to low)
            folds = { open = true, git_hl = false },
        },
        -- stylua: ignore
        styles = {
            notification_history = { border = "rounded", width = 0.8, height = 0.8, minimal = true },
            input = { title_pos = "left", height = 1, width = 50, relative = "cursor", row = -3, col = 0 },
            terminal = { relative = "editor", border = "rounded", position = "float", backdrop = 60, height = 0.9, width = 0.8, zindex = 50},
            scratch = { border = "rounded", width = 0.8, height = 0.8 ,minimal = false },
        },
    },
    -- stylua: ignore
    keys = {
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "[Snacks] Smart Find Files" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "[Snacks] Delete Buffer" },
        { "<leader>bD", function() Snacks.bufdelete.other() end, desc = "[Snacks] Delete Other Buffers" },
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "[Snacks] Notification history" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[Snacks] Find Buffers Files"},
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[Snacks] Find Nvim Config File" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "[Snacks] Find Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "[Snacks] Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "[Snacks] Recent" },
        { "<leader>ft", function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME', 'HACK' }} end, desc = "[Snacks] Todo/Fix/Fixme" },
        -- git
        { "<leader>sgb", function() Snacks.picker.git_branches() end, desc = "[Snacks] Git Branches" },
        -- Grep
        { "<leader>fg", function() Snacks.picker.grep_buffers() end, desc = "[Snacks] Grep Open Buffers" },
        { "<leader>fG", function() Snacks.picker.grep() end, desc = "[Snacks] Grep" },
        { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "[Snacks] Grep Visual selection or word", mode = { "n", "x" } },
        -- search
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[Snacks] Autocmds" },
        { "<leader>sh", function() Snacks.picker.help( { layout = "select" } ) end, desc = "[Snacks] Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[Snacks] Highlights" },
        { "<leader>sk", function() Snacks.picker.keymaps( { layout = "select" } ) end, desc = "[Snacks] Keymaps" },
        { "<leader>sc", function() Snacks.picker.colorschemes({ layout = 'select' }) end, desc = "[Snacks] Colorschemes" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "[Snacks] Marks" },
        { "<leader>sp", function() Snacks.picker.spelling({ layout = "select" }) end, desc = "[Snacks] Spelling" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "[Snacks] Undo History" },

        { "<leader>.",  function() Snacks.scratch() end, desc = "[Snacks] Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "[Snacks] Select Scratch Buffer" },
        { "<A-i>",      function() Snacks.terminal() end, desc = "[Snacks] Toggle terminal", mode = {"n",  "t"} },
        -- { "<c-g>",      function() Snacks.lazygit() end, desc = "[Snacks] Buffer Diagnostics" },
    },
    config = function(_, opts)
        require("snacks").setup(opts)
        local progress = vim.defaulttable()
        vim.api.nvim_create_autocmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
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

                local msg = {} ---@type string[]
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
    end,
}
