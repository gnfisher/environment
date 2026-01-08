return {
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- Smear cursor when switching buffers or windows
      smear_between_buffers = true,
      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to true if your font supports legacy computing symbols (block unicode symbols)
      -- Smears will look less blocky. Cascadia Code is one font that supports this.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode
      smear_insert_mode = false,

      -- Animation tuning (defaults shown, range [0, 1] unless noted)
      stiffness = 0.6,
      -- trailing_stiffness = 0.45,
      -- stiffness_insert_mode = 0.5,
      -- trailing_stiffness_insert_mode = 0.5,
      damping = 0.75,                  -- lower = more bouncy/elastic
      -- damping_insert_mode = 0.9,
      -- distance_stop_animating = 0.1,   -- > 0

      -- Performance (lower = smoother but more CPU)
      -- time_interval = 17,              -- milliseconds between draws

      -- Cursor color (defaults to Cursor GUI color)
      -- cursor_color = "#d3cdc3",        -- hex color, highlight group name, or "none"

      -- For transparent backgrounds
      -- transparent_bg_fallback_color = "#303030",

      -- For smooth cursor without smear trail
      -- matrix_pixel_threshold = 0.5,    -- use with stiffness/trailing_stiffness = 0.5

      -- Particles (fire effect)
      -- particles_enabled = false,
      -- particle_spread = 1,
      -- particles_per_second = 500,
      -- particle_max_lifetime = 800,
    },
  },
}
