return {
    {
        "mason-org/mason.nvim",
        -- event = { "BufReadPost", "BufNewFile", "VimEnter" },
        lazy = false,
        -- build = ":MasonUpdate",
        opts_extend = { "ensure_installed" },
        opts = {
            ui = { border = "rounded" },
            ensure_installed = {
                "lua-language-server", -- Lua
                "stylua", -- Lua 格式化
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require "mason-registry"
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end

            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
