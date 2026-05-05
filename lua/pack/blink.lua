-- ==============================================================
-- 代码补全 (blink.cmp) — InsertEnter 懒加载 + PackChanged 构建 hook
-- 构建命令（cargo build）通过 PackChanged 事件在安装/更新后自动执行
-- ==============================================================

vim.pack.add(
    { { src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" } },
    { load = function() end, confirm = false }
)

-- 自动构建 hook：插件安装或更新后编译 Rust 二进制
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "blink.cmp" then
            return
        end
        if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
            return
        end
        vim.notify("Building blink.cmp (Background)...", vim.log.levels.INFO)
        vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }, function(out)
            if out.code == 0 then
                vim.notify("blink.cmp build success.", vim.log.levels.INFO)
            else
                vim.notify("blink.cmp build failed: " .. (out.stderr or "Unknown"), vim.log.levels.ERROR)
            end
        end)
    end,
})

-- 懒加载：首次进入插入模式时激活
vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.cmd.packadd("blink.cmp")
        vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "#DA70D6" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#4682B4" })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#708090" })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#4682B4" })
        vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { fg = "#4682B4" })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#4682B4" })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { bg = "#1F4F42", bold = true })
        require("blink.cmp").setup({
            enabled = function()
                return not vim.tbl_contains({ "text" }, vim.bo.filetype)
            end,
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                ["<A-n>"] = {
                    function(cmp)
                        cmp.show({ providers = { "buffer" } })
                    end,
                },
            },
            cmdline = { enabled = false },
            sources = {
                default = function()
                    local success, node = pcall(vim.treesitter.get_node)
                    if
                        success
                        and node
                        and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                    then
                        return { "buffer" }
                    else
                        return { "lsp", "path", "snippets", "buffer" }
                    end
                end,
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
                providers = {
                    lsp = {
                        name = "LSP",
                        transform_items = function(_, items)
                            return vim.tbl_filter(function(item)
                                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
                            end, items)
                        end,
                        score_offset = 1000,
                        fallbacks = { "buffer" },
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 960,
                    },
                    path = {
                        name = "Path",
                        score_offset = 900,
                        opts = {
                            get_cwd = function(_)
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                    buffer = {
                        score_offset = 800,
                    },
                    snippets = {
                        name = "Snippets",
                        score_offset = 950,
                        should_show_items = function(ctx)
                            return ctx.trigger.initial_kind ~= "trigger_character"
                        end,
                        fallbacks = { "buffer" },
                    },
                },
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                menu = {
                    auto_show = true,
                    border = "rounded",
                    scrollbar = false,
                    max_height = 40,
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon" },
                            { "kind" },
                            { "source_name" },
                        },
                        treesitter = { "lsp", "snippets", "path" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    treesitter_highlighting = true,
                    window = {
                        border = "rounded",
                        scrollbar = false,
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                    scrollbar = false,
                    show_documentation = false,
                },
            },
        })
    end,
})
