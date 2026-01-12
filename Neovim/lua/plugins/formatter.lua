return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
				},

				formatters = {
					prettier = {
						timeout_ms = 5000, -- Increase timeout
						command = "prettier",
					},
				},
			})

			-- Autoformat on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html", "*.md", "*.lua" },
				callback = function(args)
					require("conform").format({
						bufnr = args.buf,
						timeout_ms = 5000,
						lsp_fallback = true,
					})
				end,
			})

			-- Manual format keymap
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
					timeout_ms = 5000,
				})
			end, { desc = "Format file" })
		end,
	},
}
