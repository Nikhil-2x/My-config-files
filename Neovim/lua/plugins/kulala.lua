return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	keys = {
		{
			"<leader>Rr",
			function()
				require("kulala").run()
			end,
			desc = "Run Request",
		},
		{
			"<leader>Ri",
			function()
				require("kulala").inspect()
			end,
			desc = "Inspect (cURL)",
		},
		{
			"<leader>Rt",
			function()
				require("kulala").toggle_view()
			end,
			desc = "Toggle Headers/Body",
		},
		{
			"<leader>Rp",
			function()
				require("kulala").jump_prev()
			end,
			desc = "Previous Request",
		},
		{
			"<leader>Rn",
			function()
				require("kulala").jump_next()
			end,
			desc = "Next Request",
		},
	},
	opts = {
		-- Optional: Change default split direction
		default_view = "body",
		display_mode = "split", -- or "float"
	},
}
