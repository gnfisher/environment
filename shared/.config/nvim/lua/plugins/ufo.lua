return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      -- nvim-ufo manages folds; disable native foldexpr
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.opt.fillchars:append({
        foldopen = "▾",
        foldclose = "▸",
        foldsep = " ",
        fold = " ",
      })

      local ufo = require("ufo")
      local function fold_virt_text_handler(virt_text, lnum, end_lnum, width, truncate)
        local new_virt_text = {}
        local folded_lines = end_lnum - lnum
        local icon = "▸"
        local count_text = string.format(" %d lines ", folded_lines)
        local suffix_width = vim.fn.strdisplaywidth(icon) + vim.fn.strdisplaywidth(count_text)
        local target_width = math.max(width - suffix_width, 0)
        local cur_width = 0

        for _, chunk in ipairs(virt_text) do
          local chunk_text = chunk[1]
          local chunk_width = vim.fn.strdisplaywidth(chunk_text)

          if cur_width + chunk_width <= target_width then
            table.insert(new_virt_text, chunk)
            cur_width = cur_width + chunk_width
          else
            local truncated = truncate(chunk_text, math.max(target_width - cur_width, 0))
            if truncated ~= "" then
              table.insert(new_virt_text, { truncated, chunk[2] })
              cur_width = cur_width + vim.fn.strdisplaywidth(truncated)
            end
            break
          end
        end

        if cur_width < target_width then
          table.insert(new_virt_text, { string.rep(" ", target_width - cur_width), "Folded" })
        end

        table.insert(new_virt_text, { icon, "Function" })
        table.insert(new_virt_text, { count_text, "LineNr" })

        return new_virt_text
      end

      ufo.setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = fold_virt_text_handler,
      })

      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zK", ufo.peekFoldedLinesUnderCursor, { desc = "Peek fold" })
    end,
  },
}
