local M = {}
local lspconfig = require("lspconfig")

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
				check = {
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
					-- ignored = {
					-- 	["async-trait"] = { "async_trait" },
					-- 	["napi-derive"] = { "napi" },
					-- 	["async-recursion"] = { "async_recursion" },
					-- },
				},
				files = {
					excludeDirs = {
						".direnv",
						".git",
						".github",
						".gitlab",
						"bin",
						"node_modules",
						"target",
						"venv",
						".venv",
					},
				},
			},
		},
	},

	-- C/C++
	clangd = {
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	},

	-- Typescript
	ts_ls = {},

	-- Python
	pyright = {
		settings = {
			pyright = {
				disableOrganizeImports = true,
			},
		},
	},
	-- Python (Ruff)
	ruff = {
		on_attach = function(client, bufnr)
			if client.name == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end

			M.on_attach(client, bufnr)
		end,
	},

	-- Move (Aptos)
	move_analyzer = {
		cmd = { "aptos-move-analyzer" },
		root_dir = lspconfig.util.root_pattern("Move.toml", ".move-root"),
	},
}

function M.on_attach(_, bufnr)
	local map = vim.keymap.set
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "gr", vim.lsp.buf.references, opts("Go to reference"))
	map("n", "gy", vim.lsp.buf.type_definition, opts("Go to type definition"))

	map("n", "<leader>r", vim.lsp.buf.rename, opts("Rename"))
	map({ "n", "v" }, "<leader>c", vim.lsp.buf.code_action, opts("Code action"))
end

function M.on_init(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

function M.default_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.semanticTokens = nil
	-- capabilities = vim.tbl_deep_extend("force", capabilities, {
	-- 	offsetEncoding = { "utf-16" },
	-- 	general = {
	-- 		positionEncodings = { "utf-16" },
	-- 	},
	-- })

	return capabilities
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.default_capabilities())

return M
