return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
					clear_suggestion = "<A-c>",
					accept_word = "<A-w>",
				},
			})
		end,
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	build = ":Copilot auth",
	-- 	opts = {
	-- 		panel = { enabled = false },
	-- 		suggestion = { enabled = false },
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("copilot").setup(opts)
	-- 	end,
	-- },
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		{ "zbirenbaum/copilot.lua" },
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 	},
	-- 	opts = {
	-- 		debug = false,
	-- 		show_help = false,
	-- 		show_folds = false,
	-- 		window = {
	-- 			width = 0.4,
	-- 			relative = "win",
	-- 			title = "AI Chat",
	-- 		},
	-- 		mappings = {
	-- 			reset = false,
	-- 			complete = {
	-- 				insert = false,
	-- 			},
	-- 		},
	-- 		question_header = "USER ",
	-- 		answer_header = "AI ",
	-- 		error_header = "ERROR ",
	-- 		separator = "─",
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("CopilotChat").setup(opts)
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>aa", "<cmd>CopilotChat<cr>", mode = { "n", "v" }, desc = "Copilot: Chat" },
	-- 		{
	-- 			"<leader>ai",
	-- 			mode = { "n", "v" },
	-- 			function()
	-- 				local input = vim.fn.input("Ask AI: ")
	-- 				if input ~= "" then
	-- 					require("CopilotChat").ask(input)
	-- 				end
	-- 			end,
	-- 			desc = "Copilot: Quick Ask",
	-- 		},
	-- 		{
	-- 			"<leader>ap",
	-- 			function()
	-- 				require("CopilotChat").select_prompt({
	-- 					context = {
	-- 						"buffers",
	-- 					},
	-- 				})
	-- 			end,
	-- 			desc = "CopilotChat - Prompt actions",
	-- 		},
	-- 		{
	-- 			"<leader>ap",
	-- 			function()
	-- 				require("CopilotChat").select_prompt()
	-- 			end,
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Prompt actions",
	-- 		},
	-- 	},
	-- },
}
