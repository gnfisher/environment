return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"typescript",
					"tsx",
					"go",
				},
				highlight = {
					enable = true,
					disable = { "markdown", "markdown_inline" },
				},
				indent = { enable = true },
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "markdown" },
				callback = function(args)
					pcall(vim.treesitter.stop, args.buf)
				end,
			})
		end,
	},
}
