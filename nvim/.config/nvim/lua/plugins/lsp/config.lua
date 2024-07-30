local M = {}

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
	map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts("Code action"))
end

function M.on_init(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
