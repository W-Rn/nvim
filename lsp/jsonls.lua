local schemas_ = require("schemastore").json.schemas {
    extra = {
        {
            description = "Pyright Configuration",
            fileMatch = { "pyrightconfig.json" },
            name = "Pyrightconfig.json",
            url = "file://" .. vim.fn.stdpath "config" .. "/schemas/pyrightconfig.schema.json",
        },
    },
    select = {
        "Pyrightconfig.json",
    },
}
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    settings = {
        json = {
            schemas = schemas_,
            -- schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
    root_markers = { ".git" },
}
