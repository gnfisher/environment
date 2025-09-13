return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
        fold = {
          enable = true
        },
				highlight = {
					enable = true,
				},
				ensure_installed = {
					"lua",
					"typescript",
					"tsx",
					"go",
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 1,
		},
	},
}
