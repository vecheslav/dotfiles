return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			-- Files
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", mode = { "n", "v" }, desc = "Telescope: Find files" },
			{ "<leader>`", "<cmd>Telescope buffers<cr>", mode = { "n", "v" }, desc = "Telescope: Find buffers" },
			{
				"<leader>fr",
				"<cmd>Telescope oldfiles<cr>",
				mode = { "n", "v" },
				desc = "Telescope: Find oldfiles",
			},
			-- Search
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live grep" },
			{ "<leader>/", '"zy<cmd>Telescope live_grep<CR><C-r>z', mode = "x", desc = "Telescope: Live grep" }, -- live grep with selection
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Telescope: Command history" },
			{
				"<leader>fc",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Telescope: Find in current buffer",
			},
			-- Marks/Help
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope: Help page" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Telescope: Find marks" },
			-- LSP
			{ "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope: Find references" },
			-- Diagnostics
			{ "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Telescope: Buffer diagnostics" },
			{ "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Telescope: Workspace diagnostics" },
			-- Git
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope: Git branches" },
		},
		config = function()
			local actions = require("telescope.actions")
			local telescope = require("telescope")

			require("telescope.pickers.layout_strategies").right_pane =
				require("plugins.telescope.layout_strategies").right_pane()

			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						".git/",
						".cache/",
						".venv/",
						"node_modules/",
						"build/",
						"dist/",
						"target/",
					},
					sorting_strategy = "ascending",
					layout_strategy = "right_pane",
					borderchars = {
						prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						results = { "─", "│", "─", "│", "│", "│", "┘", "└" },
						preview = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
					},
					results_title = "",
					preview_title = "",
					prompt_prefix = "> ",
					selection_caret = "",
					entry_prefix = "",
					get_status_text = function(self)
						-- local total = self.stats.processed or 0
						-- local matches = total - (self.stats.filtered or 0)
						--
						-- return string.format("󰈲 %s", matches)
            return ""
					end,
					multi_icon = "",
					preview = { msg_bg_fillchar = " " },
					-- preview = false,
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-c>"] = actions.delete_buffer,
						},
						n = {
							["dd"] = actions.delete_buffer,
						},
					},
				},
			})

			telescope.load_extension("ui-select")
		end,
	},
}
