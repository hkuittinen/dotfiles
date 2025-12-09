local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()
config.enable_wayland = true

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe" }
end

local default_workspaces = {
	{
		label = "dotfiles",
		cwd = wezterm.home_dir .. "/projects/dotfiles",
	},
	{
		label = "notes",
		cwd = wezterm.home_dir .. "/notes",
	},
	{
		label = "terminal",
		cwd = wezterm.home_dir,
	},
}

wezterm.on("gui-startup", function(cmd)
	for _, ws in ipairs(default_workspaces) do
		mux.spawn_window({
			workspace = ws.label,
			cwd = ws.cwd,
		})
	end
	mux.set_active_workspace("terminal")
end)

-- config.window_decorations = "RESIZE"
wezterm.on('format-window-title', function()
    return ""
end)
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.font_size = 12
-- Disable ligatures.
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

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
-- config.disable_default_key_bindings = true
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
		key = "f",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "d",
		action = wezterm.action.ShowDebugOverlay,
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action_callback(function(window, pane)
			local choices = {}
			for key, default_workspace in ipairs(default_workspaces) do
				choices[key] = {
					id = default_workspace.cwd,
					label = default_workspace.label,
				}
			end

			local ws_names = wezterm.mux.get_workspace_names()
			for _, ws_name in ipairs(ws_names) do
				local exists = false
				for _, choice in ipairs(choices) do
					if choice.label == ws_name then
						exists = true
						break
					end
				end
				if not exists then
					table.insert(choices, { label = ws_name })
				end
			end

			window:perform_action(
				act.InputSelector({
					action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
						if not id and not label then
							wezterm.log_info("cancelled")
						else
							wezterm.log_info("label = " .. label)
							inner_window:perform_action(
								act.SwitchToWorkspace({
									name = label,
									spawn = {
										label = label,
										cwd = id,
									},
								}),
								inner_pane
							)
						end
					end),
					title = "Choose workspace",
					choices = choices,
				}),
				pane
			)
		end),
	},
}

for i = 1, 9 do
	-- Leader + number to activate a tab.
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
	-- CTRL+ALT + number to move a tab to that position.
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return config
