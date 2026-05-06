-- ==============================================================
-- Plugin management commands
--   :PackUpdate  update plugins (confirmation buffer with details)
--   :PackDelete  delete plugins
-- Tab-completable plugin names; defaults to all if no arg
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

-- Floating confirm dialog
local function floating_confirm(title, message, on_confirm)
    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(message, "\n")
    table.insert(lines, 1, title)
    table.insert(lines, "")
    table.insert(lines, "[y] Confirm    [n] Cancel")

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

-- :PackUpdate — update plugins (confirmation buffer, :w to confirm / :q to discard)
vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if #opts.args > 0 then
        vim.pack.update({ opts.args })
    else
        vim.pack.update()
    end
end, {
    nargs = "?",
    desc = "Update plugins (update all if no args)",
    complete = complete_plugin,
})

-- :PackDelete — delete plugins
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
            floating_confirm("Force Delete", "Plugin " .. name .. " is still active. Confirm delete?", function()
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
            vim.notify("No inactive plugins to delete", vim.log.levels.INFO)
            return
        end
        floating_confirm("Bulk Delete",
            "Confirm delete the following " .. #inactive .. " inactive plugins?\n" .. table.concat(inactive, ", "), function()
                vim.pack.del(inactive)
            end)
    end
end, {
    nargs = "?",
    desc = "Delete plugins (delete all inactive if no args)",
    complete = complete_plugin,
})
