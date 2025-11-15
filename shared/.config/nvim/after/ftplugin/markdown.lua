local set = vim.opt_local

set.conceallevel = 2
set.concealcursor = ""
set.textwidth = 80
-- Format options:
-- t = auto-wrap text using textwidth
-- c = auto-wrap comments
-- q = allow formatting with gq
-- l = don't break lines that are already long when entering insert mode
-- n = recognize numbered lists
-- j = remove comment leader when joining lines (if supported)
set.formatoptions = "tcqln"
