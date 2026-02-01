return {
  "folke/sidekick.nvim",
  opts = {
    -- Disable Next Edit Suggestions (NES) - only using CLI integration
    nes = {
      enabled = false,
    },
    cli = {
      tools = {
        -- Set copilot as the default tool
        copilot = { cmd = { "copilot", "--banner" } },
      },
    },
  },
  keys = {
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle({ name = "copilot" }) end,
      desc = "Sidekick Toggle Copilot CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function() require("sidekick.cli").close() end,
      desc = "Detach CLI Session",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Select Prompt",
    },
  },
}
