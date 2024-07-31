return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			panel = { enabled = false },
			suggestion = { enabled = false },
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false,
			show_help = false,
			window = {
				width = 0.4,
        relative = "win",
        titl = "AI Chat",
			},
			mappings = {
				reset = false,
			},
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
			require("CopilotChat.integrations.cmp").setup()
		end,
		keys = {
			{ "<leader>co", "<cmd>CopilotChat<cr>", mode = { "n", "v" }, desc = "Copilot: Chat" },
			{
				"<leader>ca",
				mode = { "n", "v" },
				function()
					local input = vim.fn.input("Ask AI: ")
					if input ~= "" then
						require("CopilotChat").ask(input)
					end
				end,
				desc = "Copilot: Quick Ask",
			},
		},
	},
}
