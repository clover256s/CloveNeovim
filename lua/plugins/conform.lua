require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
