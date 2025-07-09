return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		config = function()
			-- Additional parsers not included in the default set
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

			-- Move (Aptos)
			parser_config.move_on_aptos = {
				install_info = {
					url = "https://github.com/aptos-labs/tree-sitter-move-on-aptos.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "main",
				},
				filetype = "move",
			}

			require("nvim-treesitter.configs").setup({
				compilers = { "clang", "gcc" },
				ensure_installed = {
					"vimdoc",
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
					"yaml",
					"json",
					"graphql",
					"proto",
					"move_on_aptos",
				},
				sync_install = false,
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<A-k>",
						node_incremental = "<A-k>",
						scope_incremental = false,
						node_decremental = "<A-j>",
					},
				},
			})
		end,
	},
}
