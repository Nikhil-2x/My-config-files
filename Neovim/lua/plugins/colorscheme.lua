return {

	{ "Shatur/neovim-ayu" },
    {
		"folke/tokyonight.nvim",
		priority = 1000, -- load BEFORE UI plugins
		config = function()
			require("tokyonight").setup({
				style = "moon", -- night | storm | moon | day
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
				},
				sidebars = { "qf", "help", "terminal", "neo-tree", "nvim-tree" },
				dim_inactive = false,
				lualine_bold = true,
			})

			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
