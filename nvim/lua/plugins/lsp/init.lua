return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre" },
		config = function()
			require("mason-lspconfig").setup({
				-- Better to install some servers manually.
				-- E.g rust-analyzer may have poor compatibility if it is not installed manually
				ensure_installed = { "lua_ls", "clangd", "ts_ls", "pyright", "ruff" },
				automatic_enable = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre" },
		config = function()
			local lsp = require("lspconfig")
			local config = require("plugins.lsp.config")

			for server, opts in pairs(config.servers) do
				local merged_opts = vim.tbl_deep_extend("force", {
					on_attach = config.on_attach,
					on_init = config.on_init,
					capabilities = config.capabilities,
				}, opts or {})

				lsp[server].setup(merged_opts)
			end
		end,
	},
}
