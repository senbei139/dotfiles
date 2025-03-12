-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.automatically_reload_config = true

-- For example, changing the color scheme:
config.color_scheme = "OneDark (base16)"
-- config.window_background_opacity = 0.93
-- config.macos_window_background_blur = 20

-- config.window_decorations = "RESIZE"

-- font
-- config.font = wezterm.font("Firge35Nerd Console")
config.font_size = 14.0
config.use_ime = true

-- bell
config.audible_bell = "Disabled"

-- scroll backline
config.scrollback_lines = 100000

-- exit
config.exit_behavior = 'CloseOnCleanExit'

-- cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 480
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.window_padding = {
 left = 3,
 right = 3,
 top = 0,
 bottom = 0 
}

local DEFAULT_FG = { Color = '#9a9eab' }

local SPACE_1 = ' '
local SPACE_3 = '   '
local HEADER_HOST = { Text = wezterm.nerdfonts.md_desktop_mac }
local HEADER_CWD = { Text = wezterm.nerdfonts.oct_file_directory }
local HEADER_GIT = { Text = wezterm.nerdfonts.md_source_branch }
local HEADER_WORKSPACE = { Text = wezterm.nerdfonts.md_rocket_launch }

local function AddElement(elems, header, str)
  table.insert(elems, { Text = header.Text .. SPACE_1 })
  table.insert(elems, { Foreground = DEFAULT_FG })
  table.insert(elems, { Text = str .. SPACE_3 })
end

local function GetGitBranch(elems, file_path)
  local handle = io.popen("git -C " .. file_path .. " rev-parse --abbrev-ref HEAD 2> /dev/null")
  local branch = handle:read("*a")
  handle:close()
  if not branch then
    return
  end
  AddElement(elems, HEADER_GIT, branch)
end

wezterm.on('update-status', function(window, pane)
  local right_elems = {}
  local left_elems = {}

  local uri = pane:get_current_working_dir()
  if not uri then
    return
  end

  AddElement(right_elems, HEADER_HOST, wezterm.hostname())
  AddElement(right_elems, HEADER_CWD, uri.file_path)

  AddElement(left_elems, HEADER_WORKSPACE, wezterm.mux.get_active_workspace())
  GetGitBranch(left_elems, uri.file_path)

  window:set_right_status(wezterm.format(right_elems))
  window:set_left_status(wezterm.format(left_elems))
end)

-- ----------------------------------------------------
-- -- Tab
-- ----------------------------------------------------
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
  font_size = 13.5,
}

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2000 }
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

return config
