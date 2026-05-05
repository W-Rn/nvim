-- ==============================================================
-- 状态栏 — VimEnter 懒加载，防止阻塞启动画面
-- ==============================================================

vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } }, { load = function() end, confirm = false })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("lualine.nvim")
        local lualine = require("lualine")
        local c = require("catppuccin.palettes").get_palette("mocha")
        -- stylua: ignore
        local colors = {
            bg        = "none",
            fg        = c.text,
            yellow    = c.yellow,
            cyan      = c.teal,
            darkblue  = c.surface0,
            green     = c.green,
            orange    = c.peach,
            violet    = c.mauve,
            magenta   = c.pink,
            blue      = c.blue,
            red       = c.red,
            bg_text   = "#333333"
        }

        local separators = {
            left = "",
            right = "",
            theme_left = "",
            theme_right = "",
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        local opts = {
            options = {
                component_separators = "",
                section_separators = "",
                theme = {
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        local function ins_left(component)
            table.insert(opts.sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(opts.sections.lualine_x, component)
        end

        ins_left({
            function()
                return separators.theme_left
            end,
            color = { fg = colors.blue },
            padding = { left = 0, right = 0 },
        })

        ins_left({
            "mode",
            icon = "",
            color = function()
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    [""] = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    no = colors.red,
                    s = colors.orange,
                    S = colors.orange,
                    [""] = colors.orange,
                    ic = colors.yellow,
                    R = colors.violet,
                    Rv = colors.violet,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ["r?"] = colors.cyan,
                    ["!"] = colors.red,
                    t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()], gui = "bold" }
            end,
            padding = { left = 1, right = 1 },
        })

        ins_left({
            "branch",
            icon = "",
            color = { fg = colors.violet, gui = "bold" },
            padding = { left = 1, right = 1 },
        })

        ins_left({
            function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
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
            end,
            color = { fg = colors.orange, gui = "bold" },
            padding = { left = 1, right = 1 },
        })

        ins_left({
            function()
                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return ""
                end
                for _, client in ipairs(clients) do
                    ---@diagnostic disable-next-line: undefined-field
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return ""
            end,
            color = { fg = colors.green, gui = "bold" },
            padding = { left = 1, right = 1 },
        })

        ins_left({
            "diff",
            symbols = { added = " ", modified = "󰝤 ", removed = " " },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
            padding = { left = 1, right = 1 },
        })

        ins_left({
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.cyan },
            },
            padding = { left = 1, right = 1 },
        })

        ins_right({
            function()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                    return ""
                else
                    return "󰑋 " .. recording_register
                end
            end,
            color = { fg = colors.bg_text, bg = colors.yellow, gui = "bold" },
            separator = { left = separators.left, right = separators.right },
            padding = { left = 1, right = 1 },
        })

        ins_right({
            "o:encoding",
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = "bold" },
        })

        ins_right({
            "fileformat",
            fmt = string.upper,
            icons_enabled = false,
            color = { fg = colors.green, gui = "bold" },
        })

        ins_right({
            "filesize",
            cond = conditions.buffer_not_empty,
            color = { fg = colors.fg, gui = "bold" },
            padding = { left = 1, right = 1 },
        })

        ins_right({
            "location",
            color = { fg = colors.fg, gui = "bold" },
            padding = { left = 1, right = 1 },
        })

        ins_right({
            "progress",
            color = { fg = colors.fg, gui = "bold" },
            padding = { left = 1, right = 1 },
        })

        ins_right({
            function()
                return separators.theme_right
            end,
            color = { fg = colors.blue },
            padding = { left = 1, right = 1 },
        })

        lualine.setup(opts)
    end,
})
