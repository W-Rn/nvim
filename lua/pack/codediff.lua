-- ==============================================================
-- 代码差异对比 — :CodeDiff 命令懒加载（含补全，首次调用时激活）
-- ==============================================================

vim.pack.add({ { src = "https://github.com/esmuellert/codediff.nvim" } }, { load = function() end, confirm = false })

local _rev_cache = { candidates = nil, git_root = nil, ts = 0 }

local function _git_refs(git_root)
    local now = vim.uv.hrtime() / 1e9
    if _rev_cache.git_root == git_root and (now - _rev_cache.ts) < 5 then
        return _rev_cache.candidates
    end
    local candidates = { "HEAD", "HEAD~1", "HEAD~2", "HEAD~3" }
    local out = vim.fn.systemlist({
        "git",
        "-C",
        git_root,
        "rev-parse",
        "--symbolic",
        "--branches",
        "--tags",
        "--remotes",
    })
    if vim.v.shell_error == 0 and out then
        vim.list_extend(candidates, out)
    end
    local stashes = vim.fn.systemlist({ "git", "-C", git_root, "stash", "list", "--pretty=format:%gd" })
    if vim.v.shell_error == 0 and stashes then
        vim.list_extend(candidates, stashes)
    end
    _rev_cache = { candidates = candidates, git_root = git_root, ts = now }
    return candidates
end

local function _codediff_complete(arg_lead, cmd_line, _)
    local args = vim.split(cmd_line, "%s+", { trimempty = true })
    if #args <= 1 then
        local candidates = { "merge", "file", "dir", "history", "install" }
        local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
        if git_dir ~= "" then
            vim.list_extend(candidates, _git_refs(vim.fn.fnamemodify(git_dir, ":h")))
        end
        return vim.tbl_filter(function(c)
            return c:find(arg_lead, 1, true) == 1
        end, candidates)
    end
    local first_arg = args[2]
    if first_arg == "merge" or first_arg == "file" then
        local base = arg_lead:match("^(.+)%.%.%.$")
        if base then
            local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
            if git_dir ~= "" then
                local refs = _git_refs(vim.fn.fnamemodify(git_dir, ":h"))
                local result = vim.tbl_map(function(r)
                    return base .. "..." .. r
                end, refs)
                table.insert(result, 1, arg_lead)
                return result
            end
        end
        return vim.fn.getcompletion(arg_lead, "file")
    end
    if first_arg == "dir" then
        return vim.fn.getcompletion(arg_lead, "dir")
    end
    if arg_lead:match("^%-") then
        local flags = { "--inline", "--side-by-side" }
        if first_arg == "history" then
            vim.list_extend(flags, { "--reverse", "-r", "--base", "-b" })
        end
        local filtered = {}
        for _, f in ipairs(flags) do
            if f:find(arg_lead, 1, true) == 1 then
                table.insert(filtered, f)
            end
        end
        if #filtered > 0 then
            return filtered
        end
    end
    return vim.fn.getcompletion(arg_lead, "file")
end

vim.api.nvim_create_user_command("CodeDiff", function(opts)
    vim.api.nvim_del_user_command("CodeDiff")
    vim.cmd.packadd("codediff.nvim")
    require("codediff").setup()
    require("codediff.commands").vscode_diff(opts)
end, {
    nargs = "*",
    bang = true,
    range = true,
    complete = _codediff_complete,
    desc = "VSCode-style diff: :CodeDiff [merge|file|dir|history|install]",
})
