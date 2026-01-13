local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({

	spec = {

		{ import = "plugins.colorscheme" },
		{ import = "plugins.kulala" },
		{ import = "plugins.wakatime" },
		{ import = "plugins.git" },
		{ import = "plugins.dashboard" },
		{ import = "plugins.formatter" },
		{ import = "plugins.explorer" },
		{ import = "plugins.Copilot" },
		{ import = "plugins.noice" },
		{ import = "plugins.toggleterm" },
		{ import = "plugins.treesitter" },

		--autoclosing tags for react
		{
			"windwp/nvim-ts-autotag",
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},

		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("telescope").setup()
			end,
		},

		-- Plugin spec for lazy.nvim
		{
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			main = "ibl", -- 👈 this is required in v3
			opts = {
				indent = { char = "│" },
				scope = { enabled = true, show_start = true, show_end = false },
			},
		},

		-- Other plugins
		{
			"akinsho/bufferline.nvim",
			config = function()
				require("bufferline").setup()
			end,
		},
		{
			"RRethy/vim-illuminate",
			config = function()
				require("illuminate").configure()
			end,
		},
		{
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("trouble").setup()
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			config = function()
				require("which-key").setup()
			end,
		},
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate",
			config = function()
				require("mason").setup()
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" },

		-- LSP setup
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
			},
			config = function()
				-- Get default capabilities for LSP
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				-- Setup mason-lspconfig with handlers
				require("mason-lspconfig").setup({
					ensure_installed = { "clangd", "lua_ls", "pyright", "ts_ls", "tailwindcss", "eslint" },
					automatic_installation = true,
					handlers = {
						-- Default handler for all servers
						function(server_name)
							require("lspconfig")[server_name].setup({
								capabilities = capabilities,
							})
						end,
					},
				})
			end,
		},

		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},
		-- { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup() end },
		-- Better autopairs config
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				local npairs = require("nvim-autopairs")
				npairs.setup({
					check_ts = true, -- Use treesitter
					fast_wrap = {
						map = "<M-e>", -- Alt+e to wrap selection
					},
				})

				-- Integration with nvim-cmp
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				local cmp = require("cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
		},
		--[[  { "neovim/nvim-lspconfig", config = function() require("lspconfig").clangd.setup {} end }, ]]
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				require("luasnip.loaders.from_vscode").lazy_load()
				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),

					sources = cmp.config.sources({
						{ name = "copilot" },
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
					}),
				})
			end,
		},
	},
})
