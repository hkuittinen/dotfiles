local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'pwsh.exe' }
end

-- config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.font_size = 12

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 64

wezterm.on("update-right-status", function(window, _)
	window:set_left_status(wezterm.format({
		{ Background = { Color = "black" } },
		{ Foreground = { Color = "darkgreen" } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = " [" .. wezterm.mux.get_active_workspace() .. "] " },
	}))
	window:set_right_status(wezterm.format({
		{ Background = { Color = "black" } },
		{ Foreground = { Color = "darkgreen" } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = wezterm.strftime(" %a %d.%m.%Y, %H:%M ") },
	}))
end)

config.colors = {
	tab_bar = {
		background = "black",
		active_tab = {
			bg_color = "darkgreen",
			fg_color = "black",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "black",
			fg_color = "darkgreen",
			intensity = "Bold",
		},
	},
}

-- Keybindings --
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		key = "m",
		mods = "LEADER",
		action = wezterm.action_callback(function(window)
			local overrides = window:get_config_overrides() or {}
			overrides.enable_tab_bar = not overrides.enable_tab_bar
			window:set_config_overrides(overrides)
		end),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = "yellow" } },
				{ Text = "New workspace name:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = ",",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = "yellow" } },
				{ Text = "Edit tab name:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		mods = "LEADER",
		key = ".",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { Color = "yellow" } },
				{ Text = "Edit workspace name:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "CTRL",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "CTRL",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "CTRL",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "l",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	{
		mods = "LEADER",
		key = "Escape",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
