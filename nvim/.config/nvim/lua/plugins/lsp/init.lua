return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("mason-lspconfig").setup({
        -- Better to install some servers manually.
        -- E.g rust-analyzer may have poor compatibility if it is not installed manually
				ensure_installed = { "lua_ls", "clangd", "tsserver", "pyright", "ruff" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			local lsp = require("lspconfig")
			local config = require("plugins.lsp.config")
			local servers = require("config.languages").servers

			lsp.util.default_config = vim.tbl_deep_extend("force", lsp.util.default_config, {
				on_attach = config.on_attach,
				on_init = config.on_init,
				capabilities = config.capabilities,
			})

			for server, opts in pairs(servers) do
				lsp[server].setup(opts)
			end
		end,
	},
}
