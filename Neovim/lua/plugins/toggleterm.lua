return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				shell = "/usr/bin/zsh", -- keep your preferred shell
				open_mapping = [[<C-\>]], -- easier than <leader>`
				insert_mappings = true,
				direction = "horizontal", -- default
				float_opts = { border = "curved" },
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
			})
		end,
	},
}
