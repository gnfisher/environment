return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"isak102/telescope-git-file-history.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		pickers = {
			find_files = {
				hidden = true,
			},
			git_files = {
				hidden = true,
			},
		},
		defaults = {
			file_ignore_patterns = {
				"node_modules/*",
			},
		},
		extensions = {
			fzf = {},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("undo")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("git_file_history")
	end,
	keys = {
		{ "<leader>ff", "<cmd>Telescope git_files<cr>", desc = "Find in git files" },
		{ "<leader>fa", "<cmd>Telescope find_files<cr>", desc = "Find all files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in files" },
    { "<space>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in buffer" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Find buffer diagnostics" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find buffer symbols" },
		{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find workspace symbols" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find commands" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
	},
}
