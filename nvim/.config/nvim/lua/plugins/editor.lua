return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Telescope: Live grep" },
			{ "<leader>/", '"zy<cmd>Telescope live_grep<CR><C-r>z', mode = "x", desc = "Telescope: Live grep" }, -- live grep with selection
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Telescope: Command history" },

			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: Find files" },
			{ "<leader>`", "<cmd>Telescope buffers<cr>", desc = "Telescope: Find buffers" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Telescope: Find oldfiles" },

			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope: Help page" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Telescope: Find marks" },
			{
				"<leader>fc",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Telescope: Find in current buffer",
			},
			{ "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Telescope: Buffer diagnostics" },
			{ "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Telescope: Workspace diagnostics" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope: Git branches" },
		},
		config = function()
			local actions = require("telescope.actions")
			local telescope = require("telescope")

			require("telescope.pickers.layout_strategies").custom_layout = Overrides.telescope_center_window()

			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "custom_layout",
					borderchars = {
						prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						results = { "─", "│", "─", "│", "│", "│", "┘", "└" },
						preview = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
					},
					results_title = "",
					preview_title = "",
					prompt_prefix = "→ ",
					selection_caret = "",
					entry_prefix = "",
					get_status_text = function(self)
						local total = self.stats.processed or 0
						local matches = total - (self.stats.filtered or 0)

						return string.format(" %s", matches)
					end,
					multi_icon = "",
					preview = { msg_bg_fillchar = " " },
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
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
		},
		config = function()
			require("nvim-tree").setup({
				prefer_startup_root = false,
				sync_root_with_cwd = true,
				respect_buf_cwd = false,
				auto_reload_on_write = false,
				disable_netrw = true,
				hijack_netrw = true,
				hijack_cursor = true,
				filters = {
					dotfiles = false,
				},
				diagnostics = {
					enable = true,
					icons = {
						hint = "●",
						info = "●",
						warning = "●",
						error = "●",
					},
				},
				filesystem_watchers = {
					enable = false,
					ignore_dirs = {
						"target",
						"build",
						"node_modules",
						".cache",
						".venv",
						".git",
					},
				},
				update_focused_file = {
					enable = true,
					update_root = false,
				},
				view = {
					width = 40,
				},
				git = {
					enable = true,
					ignore = true,
				},
				renderer = {
					add_trailing = true,
					indent_width = 2,
					highlight_git = false,
					indent_markers = {
						enable = true,
						icons = { corner = "└", edge = "│", item = "│", bottom = "─", none = " " },
					},
					icons = {
						git_placement = "after",
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = false,
						},
						glyphs = {
							default = "~",
							folder = {
								default = "󰉋",
								empty = "󰉋",
								empty_open = "󰝰",
								open = "󰝰",
								symlink = "󰉒",
								symlink_open = "󰉒",
								arrow_open = "",
								arrow_closed = "",
							},
						},
					},
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		main = "ibl",
		opts = {
			indent = { char = "▏" },
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},
	{
		"petertriho/nvim-scrollbar",
    enabled = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("scrollbar").setup({
				show_in_active_only = true,
				handle = {
					highlight = "ScrollbarColumn",
				},
				handlers = {
					cursor = false,
				},
				marks = {
					Search = {
						text = { "─", "━" },
					},
					Error = {
						text = { "─", "━" },
					},
					Warn = {
						text = { "─", "━" },
					},
					Info = {
						text = { "─", "━" },
					},
					Hint = {
						text = { "─", "━" },
					},
					Misc = {
						text = { "─", "━" },
					},
				},
			})
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			colorcolumn = "100",
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					done_icon = "✓",
				},
			},
			notification = {
				window = { x_padding = 1, y_padding = 1 },
			},
			integration = {
				-- Disable nvim tree integration since we won't open explorer on right side
				["nvim-tree"] = { enable = false },
			},
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Load the session for current directory",
			},
			{
				"<leader>qS",
				function()
					require("persistence").select()
				end,
				desc = "Select a session to load",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Load the last session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Quit the session",
			},
		},
		config = function()
			require("persistence").setup({})

			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistenceSavePre",
				callback = function()
					local status, api = pcall(require, "nvim-tree.api")
					if status then
						api.tree.close()
					end
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = {
						"mode",
						Utils.get_visual_multi,
					},
				},
			})
		end,
	},
}
