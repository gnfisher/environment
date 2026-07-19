return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("custom.treesitter_compat").setup()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"typescript",
					"tsx",
					"go",
				},
				highlight = {
					enable = not vim.g.legacy_syntax_highlighting,
					disable = { "markdown", "markdown_inline" },
				},
				indent = { enable = true },
			})

			local function use_legacy_syntax(args)
				pcall(vim.treesitter.stop, args.buf)

				local filetype = vim.bo[args.buf].filetype
				if filetype ~= "" then
					vim.bo[args.buf].syntax = filetype
				end
			end

			if vim.g.legacy_syntax_highlighting then
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "*",
					callback = use_legacy_syntax,
				})
				use_legacy_syntax({ buf = vim.api.nvim_get_current_buf() })
			else
				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "markdown" },
					callback = function(args)
						pcall(vim.treesitter.stop, args.buf)
					end,
				})
			end
		end,
	},
}
