return {
	--"iamcco/markdown-preview.nvim",
	"iamcco/markdown-preview.nvim",
	-- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install", -- 确保安装依赖
	ft = "markdown", -- 仅 Markdown 文件加载
	config = function()
		-- Markdown
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_refresh_slow = 0
		vim.g.mkdp_browser = "chromium"
		vim.g.mkdp_page_title = "「${name}」"
		vim.g.mkdp_theme = "dark"
		vim.g.mkdp_combine_preview = 1
		vim.g.mkdp_combine_preview_auto_refresh = 1
	end,
}
