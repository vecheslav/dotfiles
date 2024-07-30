return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local utils = require("catppuccin.utils.colors")
			local colors = {
				rosewater = "#ebe7da",
				flamingo = "#ebe7da",
				pink = "#ffbcad",
				mauve = "#b7c2b5",
				red = "#ff9780",
				maroon = "#ffac99",
				peach = "#ffc6a1",
				yellow = "#ffde90",
				green = "#cdd886",
				teal = "#bbddbb",
				sky = "#afd7af",
				sapphire = "#bbddbb",
				blue = "#b8e1b8",
				lavender = "#ebe7da",
				text = "#ebe7da",
				subtext1 = "#d8d5ca",
				subtext0 = "#c1beb4",
				overlay2 = "#a9a69e",
				overlay1 = "#918f88",
				overlay0 = "#7a7873",
				surface2 = "#62615d",
				surface1 = "#4a4947",
				surface0 = "#353533",
				base = "#181818",
				mantle = "#212121",
				crust = "#181818",
			}

			require("catppuccin").setup({
				show_end_of_buffer = true,
				color_overrides = {
					all = colors,
				},
				integrations = {
					indent_blankline = {
						scope_color = "overlay1",
						colored_indent_levels = false,
					},
				},
				highlight_overrides = {
					all = function(c)
						return {
							-- syntax
							["@variable.parameter"] = { fg = c.rosewater },
							-- editor
							ColorColumn = { bg = c.mantle },
							CursorLine = { bg = utils.darken(c.surface0, 0.5, c.base) },
							LineNr = { fg = c.surface1 },
							Visual = { bg = c.surface1, style = {} },
							Folded = { fg = c.overlay1, bg = c.surface0 },
							Pmenu = { bg = c.mantle, fg = c.overlay2 },
							ScrollbarColumn = { bg = c.surface0, fg = c.surface0 },
							TelescopeTitle = { fg = c.blue },
							TelescopeSelection = { fg = c.text, bg = c.surface0, style = { "bold" } },
							TelescopeBorder = { fg = c.surface0 },
							NvimTreeFolderName = { fg = c.text },
							NvimTreeFolderIcon = { fg = c.mauve },
							NvimTreeFileIcon = { fg = c.overlay2 },
							NvimTreeFileName = { fg = c.text },
							NvimTreeFolderArrowClosed = { fg = c.text },
							NvimTreeFolderArrowOpen = { fg = c.text },
							NvimTreeIndentMarker = { fg = c.surface1 },
							NvimTreeOpenedFolderName = { fg = c.text },
							NvimTreeEmptyFolderName = { fg = c.text },
							NvimTreeNormal = { fg = c.text, bg = c.none },
							NvimTreeWinSeparator = { fg = c.surface1, bg = c.none },
							NormalFloat = { fg = c.text, bg = c.mantle },
							FloatBorder = { fg = c.surface1, bg = c.mantle },
							StatusLine = { fg = c.text, bg = c.mantle },
							StatusLineNC = { fg = c.surface1, bg = c.mantle },
							VertSplit = { fg = c.surface1 },
							WinSeparator = { fg = c.surface1 },
							NeogitWinSeparator = { fg = c.surface1 },
							NeogitDiffContextHighlight = {
								bg = utils.darken(c.surface0, 0.6, c.crust),
							},
							VM_StatusLine = { fg = c.base, bg = c.text, style = { "bold" } },
							VM_Mono = { fg = c.base, bg = c.yellow },
						}
					end,
				},
			})

			vim.g.terminal_color_15 = colors.overlay0
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup()
		end,
	},
	-- {
	-- 	"rachartier/tiny-inline-diagnostic.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("tiny-inline-diagnostic").setup({
	-- 			signs = {
	-- 				arrow = " ←  ",
	-- 				up_arrow = " ↑  ",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
