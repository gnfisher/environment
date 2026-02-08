-- Multi-ripgrep for Telescope
-- Type a search pattern, then double-space to add a glob filter.
-- e.g. "handleRequest  *.go" greps for handleRequest only in .go files
-- Shortcuts: g=*.go, l=*.lua, t=*.{ts,tsx}, r=*.rb, p=*.py, j=*.{js,jsx}

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local shortcuts = {
	["g"] = "*.go",
	["l"] = "*.lua",
	["t"] = "*.{ts,tsx}",
	["j"] = "*.{js,jsx}",
	["r"] = "*.rb",
	["p"] = "*.py",
	["c"] = "*.c",
	["h"] = "*.h",
	["rs"] = "*.rs",
}

return function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.uv.cwd()

	local custom_grep = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local parts = vim.split(prompt, "  ")
			local args = { "rg", "-e", parts[1] }

			if parts[2] then
				local pattern = shortcuts[parts[2]] or parts[2]
				table.insert(args, "-g")
				table.insert(args, pattern)
			end

			return vim.list_extend(args, {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Grep (double-space to filter by glob)",
			finder = custom_grep,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end
