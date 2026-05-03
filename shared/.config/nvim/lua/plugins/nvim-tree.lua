return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeClose",
    "NvimTreeFindFile",
    "NvimTreeFocus",
    "NvimTreeOpen",
    "NvimTreeRefresh",
    "NvimTreeToggle",
  },
  keys = {
    { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    { "<leader>E", "<Cmd>NvimTreeFindFile<CR>", desc = "Reveal file in tree" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      side = "left",
      width = 34,
      preserve_window_proportions = true,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      indent_markers = {
        enable = true,
      },
    },
    filters = {
      custom = { "^\\.git$", "node_modules" },
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
  },
}
