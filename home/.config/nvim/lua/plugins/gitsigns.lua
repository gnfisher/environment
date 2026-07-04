return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(buffer)
      local gs = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      local function center_cursor()
        vim.cmd("normal! zz")
      end

      local function nav_hunk(direction)
        if vim.wo.diff then
          vim.cmd.normal({ direction == "next" and "]c" or "[c", bang = true })
        else
          gs.nav_hunk(direction)
        end
        center_cursor()
      end

      local function main_merge_base()
        for _, ref in ipairs({ "origin/main", "main" }) do
          local output = vim.fn.systemlist({ "git", "merge-base", ref, "HEAD" })
          if vim.v.shell_error == 0 and output[1] ~= nil and output[1] ~= "" then
            return output[1], ref
          end
        end
      end

      -- Navigation
      map("n", "]h", function()
        nav_hunk("next")
      end, "Next Hunk")
      map("n", "[h", function()
        nav_hunk("prev")
      end, "Prev Hunk")
      map("n", "]c", function()
        nav_hunk("next")
      end, "Next Hunk")
      map("n", "[c", function()
        nav_hunk("prev")
      end, "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
      map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>hd", gs.diffthis, "Diff This")
      map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
      map("n", "<leader>hm", function()
        if vim.b.gitsigns_main_base_enabled then
          gs.reset_base()
          vim.b.gitsigns_main_base_enabled = false
          vim.notify("Gitsigns base reset to index")
          return
        end

        local base, ref = main_merge_base()
        if base == nil then
          vim.notify("Could not find a merge base for origin/main or main", vim.log.levels.ERROR)
          return
        end

        gs.change_base(base, false, function(err)
          if err then
            vim.notify(err, vim.log.levels.ERROR)
            return
          end

          vim.b.gitsigns_main_base_enabled = true
          vim.notify("Gitsigns base set to merge-base(" .. ref .. ", HEAD)")
        end)
      end, "Toggle Hunks Since Main")
    end,
  },
}
