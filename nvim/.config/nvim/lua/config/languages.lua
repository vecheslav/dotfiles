local M = {}

M.treesitter = {
	"c",
	"cpp",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"rust",
	"lua",
	"python",
	"dockerfile",
}

M.linters = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	c = { "clangtidy" },
	cpp = { "clangtidy" },
}

M.formatters = {
	lua = { "stylua" },
	rust = { "rustfmt" },
	javascript = { "prettier" },
	c = { "clang_format" },
	cpp = { "clang_format" },
}

M.servers = {
	-- Lua
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	},

	-- Rust
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
				check = {
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
				files = {
					watcher = "server",
				},
			},
		},
	},

	-- C/C++
	clangd = {},

	-- Typescript
	tsserver = {},

	-- Python
	pyright = {
		settings = {
			pyright = {
				disableOrganizeImports = true,
			},
		},
	},
	ruff = {
		on_attach = function(client, bufnr)
			if client.name == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end

			require("plugins.lsp.config").on_attach(client, bufnr)
		end,
	},
}

return M
