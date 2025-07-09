return {
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local utils = require("catppuccin.utils.colors")
			local colors = require("plugins.ui.colors")

			require("catppuccin").setup({
				show_end_of_buffer = true,
				color_overrides = {
					all = colors,
				},
				integrations = {
					indent_blankline = {
						scope_color = "overlay0",
						colored_indent_levels = false,
					},
				},
				highlight_overrides = {
					all = function(c)
						return {
							-- syntax
							["@variable.parameter"] = { fg = c.rosewater },
							-- ["@comment"] = { fg = c.surface1, style = { "italic" } },
							Comment = { fg = c.overlay0 },
							SpecialComment = { fg = c.overlay0 },
							Operator = { fg = c.text },
							-- editor
							ColorColumn = { bg = c.mantle },
							Cursor = { fg = c.base, bg = c.text },
							CursorLine = { bg = utils.darken(c.surface0, 0.5, c.base) },
							LineNr = { fg = c.surface1 },
							Visual = { bg = "#176080", fg = c.text, style = {} },
							-- Visual = { bg = c.surface0 },
							Folded = { fg = c.overlay1, bg = c.surface0 },
							Pmenu = { bg = c.mantle, fg = c.overlay2 },
							PmenuSel = { bg = c.surface0, fg = c.mauve },
							ScrollbarColumn = { bg = c.surface0, fg = c.surface0 },
							TelescopeTitle = { fg = c.blue },
							TelescopeSelection = { fg = c.text, bg = c.surface0, style = { "bold" } },
							TelescopeBorder = { fg = c.surface0 },
							NormalFloat = { fg = c.text, bg = c.mantle },
							FloatBorder = { fg = c.surface1, bg = c.mantle },
							StatusLine = { fg = c.text, bg = c.mantle },
							StatusLineNC = { fg = c.surface1, bg = c.mantle },
							VertSplit = { fg = c.surface1 },
							WinSeparator = { fg = c.surface1 },
							NvimTreeFolderName = { fg = c.text },
							NvimTreeFolderIcon = { fg = c.subtext0 },
							NvimTreeFileIcon = { fg = c.overlay2 },
							NvimTreeExecFile = { fg = c.text },
							NvimTreeImageFile = { fg = c.text },
							NvimTreeSpecialFile = { fg = c.text },
							NvimTreeFolderArrowClosed = { fg = c.text },
							NvimTreeFolderArrowOpen = { fg = c.text },
							NvimTreeIndentMarker = { fg = c.surface1 },
							NvimTreeOpenedFolderName = { fg = c.text },
							NvimTreeWinSeparator = { fg = c.surface1, bg = c.none },
							NvimTreeEmptyFolderName = { fg = c.text },
							NvimTreeNormal = { fg = c.text, bg = c.none },
							NeogitWinSeparator = { fg = c.surface1 },
							NeogitDiffContextHighlight = {
								bg = utils.darken(c.surface0, 0.6, c.crust),
							},
							VM_StatusLine = { fg = c.base, bg = c.text, style = { "bold" } },
							VM_Mono = { fg = c.base, bg = c.yellow },
							IndentLine = { fg = c.surface0 },
							IndentLineCurrent = { fg = c.overlay0 },
							CopilotStatusLine = { fg = c.peach, bg = c.mantle },
							CopilotEnabledStatusLine = { fg = c.green, bg = c.mantle },
							-- More colors for icons
							MiniIconsAzure = { fg = "#abb5dd" },
						}
					end,
				},
			})

			vim.g.terminal_color_15 = colors.overlay0
			vim.cmd("colorscheme catppuccin")
		end,
	},
	-- {
	-- 	"armannikoyan/rusty",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme rusty")
	-- 	end,
	-- },
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup()
		end,
	},
	{
		"echasnovski/mini.icons",
		opts = require("plugins.ui.icons"),
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	-- {
	-- 	"rachartier/tiny-inline-diagnostic.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("tiny-inline-diagnostic").setup({
	-- 			multiple_diag_under_cursor = true,
	-- 			signs = {
	-- 				arrow = " ←  ",
	-- 				up_arrow = " ↑  ",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
