return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				ensure_installed = {
					"cpp",
					"c",
					"lua",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"css",
					"html",
					"http",
					"graphql",
				},
			})
		end,
	},
}
