-- ==============================================================
-- 浮动终端 — :ToggleTerm + :TermExec + <A-\> 按键懒加载
-- ==============================================================

vim.pack.add({ { src = "https://github.com/akinsho/toggleterm.nvim" } }, { load = function() end, confirm = false })

local function load_toggleterm()
    vim.api.nvim_del_user_command("ToggleTerm")
    vim.api.nvim_del_user_command("TermExec")
    vim.cmd.packadd("toggleterm.nvim")
    require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
    })
end

-- 按键映射
vim.keymap.set({ "n", "t" }, "<A-\\>", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- 补全辅助函数（镜像 toggleterm.commandline 的行为）
local function _toggle_complete(options)
    return function(lead, cmdline, _)
        local key, value = lead:match("^(%w+)=?(.*)$")
        local opt = options[key]
        if opt and type(opt) == "function" then
            local results = opt(value or "")
            return vim.tbl_map(function(o)
                return key .. "=" .. o
            end, results)
        end
        local available = vim.tbl_filter(function(k)
            return not cmdline:match(" " .. k .. "=")
        end, vim.tbl_keys(options))
        table.sort(available)
        return vim.tbl_map(function(k)
            return k .. "="
        end, available)
    end
end

local _dirs = { "float", "horizontal", "tab", "vertical" }
local function _match_dirs(typed)
    if typed == "" then
        return _dirs
    end
    return vim.tbl_filter(function(d)
        return d:match("^" .. typed)
    end, _dirs)
end

local _termexec_opts = {
    cmd = function(typed)
        local cmds = {}
        for _, p in ipairs(vim.split(vim.env.PATH, ":")) do
            for _, f in ipairs(vim.split(vim.fn.glob(p .. "/" .. (typed or "") .. "*"), "\n")) do
                if f ~= "" then
                    table.insert(cmds, vim.fn.fnamemodify(f, ":t"))
                end
            end
        end
        return cmds
    end,
    dir = function(typed)
        local base, search = "", typed or ""
        if vim.fn.isdirectory(typed or ".") == 1 then
            base, search = typed:gsub("/$", ""), ""
        elseif (typed or ""):find("/", 2) then
            base, search = vim.fn.fnamemodify(typed, ":h"), vim.fn.fnamemodify(typed, ":t")
            if vim.fn.isdirectory(base) ~= 1 then
                return {}
            end
        end
        return vim.tbl_map(
            function(p)
                return (base ~= "" and base .. "/" or "") .. p
            end,
            vim.tbl_filter(
                function(p)
                    return p:match("^" .. search) ~= nil
                end,
                vim.fn.readdir(base ~= "" and base or ".", function(e)
                    return vim.fn.isdirectory((base ~= "" and base .. "/" or "") .. e)
                end)
            )
        )
    end,
    direction = _match_dirs,
    size = function()
        return {}
    end,
    name = function()
        return {}
    end,
}

local _togg_opts = {
    dir = _termexec_opts.dir,
    direction = _match_dirs,
    size = function()
        return {}
    end,
    name = function()
        return {}
    end,
}

-- 临时 :ToggleTerm 命令
vim.api.nvim_create_user_command("ToggleTerm", function(opts)
    load_toggleterm()
    require("toggleterm").toggle_command(opts.args, opts.count)
end, {
    count = true,
    nargs = "*",
    complete = _toggle_complete(_togg_opts),
})

-- 临时 :TermExec 命令（供 run.lua / 命令行直接调用）
vim.api.nvim_create_user_command("TermExec", function(opts)
    load_toggleterm()
    require("toggleterm").exec_command(opts.args, opts.count)
end, {
    count = true,
    nargs = "*",
    complete = _toggle_complete(_termexec_opts),
})
