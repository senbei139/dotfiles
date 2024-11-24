-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.automatically_reload_config = true

-- For example, changing the color scheme:
config.color_scheme = "OneDark (base16)"
config.window_background_opacity = 0.93
config.macos_window_background_blur = 20

-- font
-- config.font = wezterm.font("Firge35Nerd Console")
config.font_size = 14.5
config.use_ime = true

-- bell
config.audible_bell = "Disabled"

-- scroll backline
config.scrollback_lines = 100000

-- exit
config.exit_behavior = 'CloseOnCleanExit'


config.window_padding = {
 left = 0,
 right = 0,
 top = 0,
 bottom = 0 
}

local DEFAULT_FG = { Color = '#9a9eab' }
local DEFAULT_BG = { Color = '#333333' }

local SPACE_1 = ' '
local SPACE_3 = '   '
local HEADER_HOST = { Foreground = { Color = '#75b1a9' }, Text = '' }
local HEADER_CWD = { Foreground = { Color = '#92aac7' }, Text = '' }

local function AddElement(elems, header, str)
  table.insert(elems, { Foreground = header.Foreground })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = header.Text .. SPACE_1 })

  table.insert(elems, { Foreground = DEFAULT_FG })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Attribute = {font_size = 19} })
  table.insert(elems, { Text = str .. SPACE_3 })
end

local function GetGitBranch(elems, file_path)
  local handle = io.popen("git -C " .. file_path .. " rev-parse --abbrev-ref HEAD 2> /dev/null")
  local branch = handle:read("*a")
  handle:close()
  AddElement(elems, HEADER_CWD, branch)
end

local function GetHostAndCwd(elems, pane, file_path)
  local username = os.getenv('USER') or os.getenv('LOGNAME') or os.getenv('USERNAME')
  AddElement(elems, HEADER_HOST, wezterm.hostname())
  AddElement(elems, HEADER_CWD, file_path)
end

local function RightUpdate(window, pane)
end

wezterm.on('update-status', function(window, pane)
  local elems = {}

  local uri = pane:get_current_working_dir()
  GetHostAndCwd(elems, pane, uri.file_path)
  GetGitBranch(elems, uri.file_path)

  window:set_right_status(wezterm.format(elems))
end)

-- ----------------------------------------------------
-- -- Tab
-- ----------------------------------------------------
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_frame = {
  font_size = 13.0,
}

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2000 }
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

return config
