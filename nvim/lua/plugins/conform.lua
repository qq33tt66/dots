require("conform").setup({
	formatters_by_ft = {
		html = { "prettier" },
		css = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		svelte = { "prettier" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
