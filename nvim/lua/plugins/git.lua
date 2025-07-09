return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "-" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				local function opts(desc)
					return { buffer = bufnr, desc = desc }
				end

				local map = vim.keymap.set

				map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", opts("Previous hunk"))
				map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", opts("Next hunk"))
				map("n", "<leader>hc", "<cmd>Gitsigns toggle_current_line_blame<cr>", opts("Toggle current line blame"))
				map("n", "<leader>hh", "<cmd>Gitsigns preview_hunk_inline<cr>", opts("Preview hunk"))
			end,
		},
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>gs", "<cmd>Neogit<cr>", desc = "Git status" },
		},
		config = function()
			require("neogit").setup({
				kind = "split",
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diffview" },
			{ "<leader>gf", "<cmd>DiffviewFileHistory<cr>", desc = "Git diffview file history" },
		},
		config = function()
			require("diffview").setup({
				use_icons = false,
				enhanced_diff_hl = true,
				file_panel = {
					listing_style = "list",
				},
				keymaps = {
					view = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview tab" } },
					},
					file_panel = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview tab" } },
					},
					file_history_panel = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview tab" } },
					},
				},
			})

			-- Border overrides
			-- require("diffview.ui.panel").Panel.default_config_float.border = "none"
		end,
	},
}
