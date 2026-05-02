return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
        "main.py",
        ".venv",
    },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic", -- 可选: "off", "basic", "strict"
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- 或 "openFilesOnly"
                useLibraryCodeForTypes = true,
                autoImportCompletions = true, -- 启用自动导入补全
            },
        },
    },
}
