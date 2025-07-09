return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>=",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				desc = "Format file",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				toml = { "taplo" },
				move = { "movefmt" },
			},
			formatters = {
        -- Move (Aptos)
				movefmt = {
					command = "movefmt",
					args = { "--emit", "stdout", "-q", "--file-path", "$FILENAME" },
					env = { MOVEFMT_LOG = "movefmt=ERROR" },
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},
}
