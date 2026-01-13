return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false }, -- disable inline ghost text
				panel = { enabled = false }, -- disable Copilot panel
			})
		end,
	},

	-- Bridge between Copilot and nvim-cmp
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Copilot Chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- you already have this
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- required for token counting
		opts = {
			debug = false, -- set true to see logs if something breaks
			-- You can also configure window layout here
			window = {
				layout = "vertical", -- or 'vertical', 'horizontal'
				-- width = 0.8,
				-- height = 0.8,
				width = 40,
			},
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
		end,
	},
}
