return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
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
			formatters_by_ft = require("config.languages").formatters,
		},
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},
}
