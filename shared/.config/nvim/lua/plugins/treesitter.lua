return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			-- Neovim 0.12 can pass quantified captures (lists of nodes) to this directive.
			-- nvim-treesitter's default handler expects a single node and crashes on markdown fences.
			local query = require("vim.treesitter.query")
			local markdown_aliases = {
				ex = "elixir",
				pl = "perl",
				sh = "bash",
				uxn = "uxntal",
				ts = "typescript",
			}
			local function pick_capture_node(capture)
				if type(capture) ~= "table" then
					return capture
				end

				for _, node in ipairs(capture) do
					if node ~= nil then
						return node
					end
				end

				return nil
			end

			query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
				local capture_id = pred[2]
				local node = pick_capture_node(match[capture_id])
				if not node then
					return
				end

				local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
				local language = vim.filetype.match({ filename = "a." .. injection_alias })
					or markdown_aliases[injection_alias]
					or injection_alias
				metadata["injection.language"] = language
			end, vim.fn.has("nvim-0.10") == 1 and { force = true, all = false } or true)

			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"typescript",
					"tsx",
					"go",
				},
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
						},
					},
				},
			})

			-- Explicit mappings to override Vim builtins (]f = file under cursor)
			local opts = { noremap = false, silent = true }
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer")
			end, opts)
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer")
			end, opts)
			vim.keymap.set({ "n", "x", "o" }, "]F", function()
				require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer")
			end, opts)
			vim.keymap.set({ "n", "x", "o" }, "[F", function()
				require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer")
			end, opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 1,
		},
	},
}
