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
		{ import = "plugins.lazygit" },
		{ import = "plugins.dashboard" },
		{ import = "plugins.formatter" },
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

		-- File explorer
		-- nvim-tree
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("nvim-tree").setup({
					filters = { dotfiles = false, git_ignored = false },
				})
			end,
		},

		--Oil.nvim
		{
			"stevearc/oil.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("oil").setup({
					view_options = { show_hidden = true },
				})
			end,
		},

		-- Status line
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("lualine").setup()
			end,
		},
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

		-- Copilot core
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

		-- Git integration
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup({
					signs = {
						add = { text = "│" },
						change = { text = "│" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
					},
					current_line_blame = true, -- Show blame on current line
					current_line_blame_opts = {
						delay = 500, -- Show after 0.5s
					},
				})
			end,
		},

		-- Other plugins
		{
			"akinsho/bufferline.nvim",
			config = function()
				require("bufferline").setup()
			end,
		},
		{
			"folke/noice.nvim",
			dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
			config = function()
				require("noice").setup({
					lsp = {
						override = {
							["vim.lsp.util.convert_input_to_markdown_lines"] = true,
							["vim.lsp.util.stylize_markdown"] = true,
							["cmp.entry.get_documentation"] = true,
						},
					},
					presets = {
						bottom_search = true,
						command_palette = false,
						long_message_to_split = true,
						inc_rename = false,
						lsp_doc_border = true,
					},
				})
				local notify = require("notify")
				notify.setup({
					stages = "fade_in_slide_out",
					timeout = 3000,
					background_colour = "#000000",
					render = "minimal",
				})
				vim.notify = notify
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
		--   {
		--     "neovim/nvim-lspconfig",
		--     dependencies = {
		--       "williamboman/mason.nvim",
		--       "williamboman/mason-lspconfig.nvim",
		--     },
		--     config = function()
		--       local mason_lspconfig = require("mason-lspconfig")
		--       local lspconfig = require("lspconfig")
		--
		--       mason_lspconfig.setup {
		--         ensure_installed = { "clangd", "lua_ls", "pyright","ts_ls","tailwindcss","eslint" },
		--         automatic_installation = true,
		--       }
		--
		--       -- Manually loop over installed servers
		-- for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
		--   lspconfig[server].setup {
		--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
		--   }
		-- end
		--
		--     end
		--   },
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
