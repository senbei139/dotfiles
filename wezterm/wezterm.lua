-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.automatically_reload_config = true

-- Avoid full-window flickering with the OpenGL renderer on macOS.
-- WebGpu uses Metal on macOS.
config.front_end = "WebGpu"

-- Color Scheme
config.colors = require("colors")
-- config.color_scheme = 'Google Dark (base16)'
-- config.color_scheme = 'Spacemacs (base16)'

-- config.macos_window_background_blur = 20

-- config.window_decorations = "RESIZE"
--
-- window size
config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true
config.initial_rows = 38
config.initial_cols = 113

config.window_padding = {
  left = 3,
  right = 3,
  top = 0,
  bottom = 0
}

-- font
config.font = wezterm.font("Firge35Nerd Console")
config.font_size = 14.0
config.harfbuzz_features = {
  "liga=0",
  "clig=0",
  "calt=0",
}
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


-- ----------------------------------------------------
-- -- Session
-- -- NOTE: enable_tab_bar = false のため現在は表示されない
-- ----------------------------------------------------

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
-- -- Window Title
-- -- タブバーを消しているぶんの情報をタイトルバーで補う。
-- -- 例: "default · 2/3 · nvim" (workspace · タブ位置 · タブ名)
-- -- NOTE: macOS のタイトルバーはシステムフォントで描画されるため
-- --       Nerd Font のアイコンは使えない。
-- -- NOTE: cwd は OSC 7 依存で tmux 内では更新されないので載せない。
-- --       tmux 内の cwd/git は tmux のステータスライン側に任せる。
-- ----------------------------------------------------
local function WindowWorkspace(tab)
  -- ウィンドウが複数ある場合に取り違えないよう、まずは自分の window から引く
  local ok, name = pcall(function()
    return wezterm.mux.get_window(tab.window_id):get_workspace()
  end)
  if ok and name then
    return name
  end
  return wezterm.mux.get_active_workspace()
end

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  -- タブ名は未設定なら実行中プログラム名 (pane.title) で代用
  local title = tab.tab_title
  if title == nil or title == '' then
    title = pane.title
  end

  return string.format('%s · %d/%d · %s',
    WindowWorkspace(tab), tab.tab_index + 1, #tabs, title)
end)

-- ----------------------------------------------------
-- -- Tab
-- ----------------------------------------------------
-- タブバー（下部ステータス）を非表示
config.enable_tab_bar = false
-- config.tab_bar_at_bottom = true
-- config.show_tabs_in_tab_bar = false
-- config.show_new_tab_button_in_tab_bar = false
-- config.window_frame = {
--   font_size = 13.5,
-- }

-- ----------------------------------------------------
-- -- Pane
-- ----------------------------------------------------
config.inactive_pane_hsb = {
  brightness = 0.8,
}

----------------------------------------------------
-- keybinds
----------------------------------------------------
-- tmux の prefix (C-Space) と衝突しないよう SHIFT を足している
config.leader = { key = "phys:Space", mods = "CTRL|SHIFT", timeout_milliseconds = 2000 }
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

return config
