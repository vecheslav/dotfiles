return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"garymjr/nvim-snippets",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				auto_brackets = {},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					documentation = {
						zindex = 100,
					},
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = function(_, item)
						item.menu = ""
						return item
					end,
				},
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if vim.snippet.active({ direction = 1 }) then
							vim.snippet.jump(1)
						else
							-- Respect ai autocomplete
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if vim.snippet.active({ direction = -1 }) then
							vim.snippet.jump(-1)
						else
							-- Respect ai autocomplete
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "snippets" },
					{ name = "buffer" },
					{ name = "path" },
				},
			}
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
	{
		"garymjr/nvim-snippets",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		branch = "main",
		opts = {
			friendly_snippets = true,
		},
	},
}
