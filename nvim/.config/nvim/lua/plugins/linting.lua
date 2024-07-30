return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = require("config.languages").linters

			local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
				group = lint_autogroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
