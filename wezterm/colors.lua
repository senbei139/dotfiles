local wezterm = require("wezterm")

return {
  background = "#1f2022",
  foreground = "#E8EAED",

  cursor_bg = "#E8EAED",
  cursor_fg = "#0d1117",
  cursor_border = "#58a6ff",

  selection_fg = "#ffffff",
  selection_bg = "#30363d",

  -- scrollbar_thumb = "#484f58",
  -- The color of the split lines between panes
  split = "#fcfcfc",

  ansi = {
    "#202124",
    "#EA4335",
    "#34A853",
    "#FBBC04",
    "#4285F4",
    "#3142F4",
    "#24C1E0",
    "#E8EAED",
  },
  brights = {
    "#5F6368",
    "#EA4335",
    "#34A853",
    "#FBBC05",
    "#4285F4",
    "#A142F4",
    "#24C1E0",
    "#FFFFFF",
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  -- indexed = { [136] = "#af8700" },

  -- copy_mode_active_highlight_bg = { Color = "#000000" },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = "Black" },
  copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
  copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

  -- quick_select_label_bg = { Color = "peru" },
  -- quick_select_label_fg = { Color = "#ffffff" },
  -- quick_select_match_bg = { AnsiColor = "Navy" },
  -- quick_select_match_fg = { Color = "#ffffff" },
}
