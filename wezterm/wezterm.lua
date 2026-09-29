local wezterm = require('wezterm')
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'Kitty Default'

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' })

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.window_background_opacity = 0.9
config.wayland_window_background_blur = true

config.max_fps = 144
config.animation_fps = 144

config.initial_cols = 125
config.scrollback_lines = 10000
config.enable_scroll_bar = true

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32
local tab_bar_bg = "#050505"
local inactive_tab_hovered_fg = '#ffffff'
local inactive_tab_hovered_bg = '#232323'
config.colors = {
	tab_bar = {
		background = tab_bar_bg,
		inactive_tab_hover = {
			bg_color = inactive_tab_hovered_bg,
			fg_color = inactive_tab_hovered_fg,
			italic = false
		}
	},
}
wezterm.on("format-tab-title", function(tab, --[[tabs]] _, --[[panes]] _, --[[config]] _, hover, max_width)
	local tab_bg = tab_bar_bg
	local tab_fg = "#babec4"
	local terminal_bg = "#050505"

	if tab.is_active then
		tab_bg = "#f0b72f"
		tab_fg = "#050505"
	elseif hover then
		tab_bg = inactive_tab_hovered_bg
		tab_fg = inactive_tab_hovered_fg
	end

	-- 1 cell for a padding space between the tabs
	-- 1 cell for 
	-- 3 cells for tab index, ':' and ' ' (assuming tab index < 10)
	-- 1 cell for 
	local title_width = math.max(0, max_width - 6)

	local title = tab.active_pane.title
	if title:len() > title_width then
		title = title:sub(1, title_width - 1) .. '…'
	end

	return {
		-- one space for padding between tabs
		{ Background = { Color = terminal_bg } },
		{ Text = " " },

		-- Left rounded edge
		{ Background = { Color = terminal_bg } },
		{ Foreground = { Color = tab_bg } },
		{ Text = "" },

		-- Body
		{ Background = { Color = tab_bg } },
		{ Foreground = { Color = tab_fg } },
		{ Text = (tab.tab_index + 1) .. ': ' .. title },

		-- Right rounded edge
		{ Background = { Color = terminal_bg } },
		{ Foreground = { Color = tab_bg } },
		{ Text = "" },
	}
end)

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 0.9,
}

config.leader = {
	key = ' ',
	mods = 'CTRL',
	timout_milliseconds = 1000
}
config.keys = {
	{
		key = 'h',
		mods = 'SHIFT|ALT',
		action = act.ActivateTabRelative(-1)
	},
	{
		key = 'l',
		mods = 'SHIFT|ALT',
		action = act.ActivateTabRelative(1)
	},
	{
		key = 'c',
		mods = 'LEADER',
		action = act.SpawnTab('CurrentPaneDomain')
	},
	{
		key = '"',
		mods = 'LEADER|SHIFT',
		action = act.SplitVertical({})
	},
	{
		key = '%',
		mods = 'LEADER|SHIFT',
		action = act.SplitHorizontal({})
	}
}
-- leader+number to jump to tab
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = 'LEADER',
		-- index of leftmost tab is 0
		action = act.ActivateTab(i - 1)
	})
end
-- lowers the default mouse wheel scroll amount
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = 'NONE',
		action = act.ScrollByLine(-3),
		alt_screen = false
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = 'NONE',
		action = act.ScrollByLine(3),
		alt_screen = false
	},
}

-- experimental
if false then
	config.scroll_bar_rounded = true
end

return config
