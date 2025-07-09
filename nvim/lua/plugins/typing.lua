return {
	-- Multi cursor
	{
		"mg979/vim-visual-multi",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		branch = "master",
		init = function()
			vim.g.VM_leader = "\\"
			vim.g.VM_show_warnings = 0
			vim.g.VM_set_statusline = 0 -- disable VM's statusline updates to prevent clobbering
			vim.g.VM_silent_exit = 1
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<C-A-j>",
				["Add Cursor Up"] = "<C-A-k>",
			}
		end,
	},
	-- Autoclose pairs/brackets
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- Comments
	-- FIXME: Neovim has his built-in commenting https://github.com/neovim/neovim/pull/28176
	-- But for now it has minimal functionality.
	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("Comment").setup()
	-- 	end,
	-- },
	-- Helper to remember shortcuts
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 600,
			win = {
				padding = { 1, 0 },
				title = false,
			},
			icons = {
				rules = false,
			},
			show_help = false,
			show_keys = false,
		},
	},
}
