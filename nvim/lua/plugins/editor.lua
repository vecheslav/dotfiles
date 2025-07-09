return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys = {
			{
				"<leader>e",
				function()
					if vim.fn.bufname():match("NvimTree_") then
						vim.cmd("NvimTreeToggle")
					else
						vim.cmd("NvimTreeFocus")
					end
				end,
				desc = "Toggle file explorer",
			},
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
					custom = { ".git$" },
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
					width = 36,
				},
				trash = {
					cmd = "trash",
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
							file = true,
							folder = true,
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
		"m4xshen/smartcolumn.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			colorcolumn = "100",
			editorconfig = true,
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
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_y = {
						function()
							return vim.b["visual_multi"] and "%#VM_StatusLine#󰮫 MULTI" or ""
						end,
						"progress",
					},
				},
			})
		end,
	},
}
