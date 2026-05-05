-- ==============================================================
-- 插件管理命令
--   :PackUpdate 更新插件（弹出确认 buffer 展示详情）
--   :PackDelete 删除插件
-- 均支持 Tab 补全插件名，无参数时默认全部
-- ==============================================================

local function get_managed_names()
    local names = {}
    for _, p in ipairs(vim.pack.get()) do
        table.insert(names, p.spec.name)
    end
    return names
end

local function complete_plugin(arg_lead)
    return vim.tbl_filter(function(name)
        return name:find(arg_lead, 1, true) == 1
    end, get_managed_names())
end

-- 浮动确认弹框（替代 vim.ui.input）
local function floating_confirm(title, message, on_confirm)
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(message, "\n")
    table.insert(lines, 1, title)
    table.insert(lines, "")
    table.insert(lines, "[y] 确认    [n] 取消")

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].buftype = "nofile"

    local max_width = 0
    for _, line in ipairs(lines) do
        max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
    end
    local width = math.max(max_width + 4, 40)
    local height = #lines + 2

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 3),
        col = math.floor((vim.o.columns - width) / 2),
        border = "rounded",
        style = "minimal",
    })

    local function close(action)
        vim.api.nvim_win_close(win, true)
        vim.api.nvim_buf_delete(buf, { force = true })
        if action then
            action()
        end
    end

    local opts = { buffer = buf, nowait = true, silent = true }
    vim.keymap.set("n", "y", function() close(on_confirm) end, opts)
    vim.keymap.set("n", "Y", function() close(on_confirm) end, opts)
    vim.keymap.set("n", "n", function() close() end, opts)
    vim.keymap.set("n", "N", function() close() end, opts)
    vim.keymap.set("n", "<Esc>", function() close() end, opts)
    vim.keymap.set("n", "q", function() close() end, opts)
end

-- :PackUpdate — 更新插件（确认 buffer 展示详情，:w 确认 / :q 放弃）
vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if #opts.args > 0 then
        vim.pack.update({ opts.args })
    else
        vim.pack.update()
    end
end, {
    nargs = "?",
    desc = "更新插件（无参数则更新全部）",
    complete = complete_plugin,
})

-- :PackDelete — 删除插件
vim.api.nvim_create_user_command("PackDelete", function(opts)
    if #opts.args > 0 then
        local name = opts.args
        local is_active = false
        for _, p in ipairs(vim.pack.get()) do
            if p.spec.name == name and p.active then
                is_active = true
                break
            end
        end
        if is_active then
            floating_confirm("强制删除", "插件 " .. name .. " 仍活跃，确认删除？", function()
                vim.pack.del({ name }, { force = true })
            end)
        else
            vim.pack.del({ name })
        end
    else
        local inactive = {}
        for _, p in ipairs(vim.pack.get()) do
            if not p.active then
                table.insert(inactive, p.spec.name)
            end
        end
        if #inactive == 0 then
            vim.notify("没有非活跃插件可删除", vim.log.levels.INFO)
            return
        end
        floating_confirm("批量删除",
            "确认删除以下 " .. #inactive .. " 个非活跃插件？\n" .. table.concat(inactive, ", "), function()
                vim.pack.del(inactive)
            end)
    end
end, {
    nargs = "?",
    desc = "删除插件（无参数则删除全部非活跃插件）",
    complete = complete_plugin,
})
