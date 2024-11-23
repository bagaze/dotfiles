-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.initial_rows = 30
config.initial_cols = 120

-- Font
config.font = wezterm.font("Iosevka Term", {
	-- stretch = "Expanded",
	weight = "Bold",
})
config.font_size = 15.0
config.color_scheme = "Catppuccin Frappe"
config.bold_brightens_ansi_colors = true

-- System
config.audible_bell = "Disabled"
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 10
config.use_ime = false

-- window
config.window_background_opacity = 0.97
config.macos_window_background_blur = 30
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

-- Use kitty protocol
config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

-- Disable action bar
config.window_decorations = "RESIZE"

-- Cursor
config.default_cursor_style = "BlinkingBar"

-- tabbar
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 80
-- config.tab_and_split_indices_are_zero_based = true

-- system
config.term = "xterm-256color"

-- Special key mapping for nvim
-- From: https://github.com/wez/wezterm/issues/3731#issuecomment-1592198263
local function is_vim(pane)
	return (pane:get_foreground_process_name() or ""):find("n?vim") ~= nil
	-- local is_vim_env = pane:get_user_vars().IS_NVIM == "true"
	-- if is_vim_env == true then
	-- 	return true
	-- end
	-- -- This gsub is equivalent to POSIX basename(3)
	-- -- Given "/foo/bar" returns "bar"
	-- -- Given "c:\\foo\\bar" returns "bar"
	-- local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	-- return process_name == "nvim" or process_name == "vim"
end

-- cmd+keys that we want to send to neovim.
local super_vim_keys_map = {
	c = {
		utf8.char(0xAA),
		{ CopyTo = "ClipboardAndPrimarySelection" },
	},
	w = {
		utf8.char(0xAB),
		{ CloseCurrentTab = { confirm = false } },
	},
}

local function bind_super_key_to_vim(key)
	return {
		key = key,
		mods = "CMD",
		action = wezterm.action_callback(function(win, pane)
			local char, wez_action = table.unpack(super_vim_keys_map[key])
			if char and is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = char, mods = nil },
				}, pane)
			else
				win:perform_action(wez_action, pane)
			end
		end),
	}
end

--- in your wezterm keys config, use it like:
config.keys = {
	bind_super_key_to_vim("c"),
	bind_super_key_to_vim("w"),
	-- {
	-- 	key = "w",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.CloseCurrentTab({ confirm = true }),
	-- },
	{ key = "Backspace", mods = "CMD", action = wezterm.action.SendKey({ key = "u", mods = "CTRL" }) },
	-- Sends ESC + b and ESC + f sequence, which is used
	-- for telling your shell to jump back/forward.
	{
		-- When the left arrow is pressed
		key = "LeftArrow",
		-- With the "Option" key modifier held down
		mods = "OPT",
		-- Perform this action, in this case - sending ESC + B
		-- to the terminal
		action = wezterm.action.SendString("\x1bb"),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bf"),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.SendString("\x05"),
	},
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.SendString("\x01"),
	},
	{
		key = "i",
		mods = "CMD|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			-- initial_value = "My Tab Name",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Create a new tab in the same domain as the current pane.
	{
		key = "t",
		mods = "CMD",
		action = act({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }),
	},
	-- Create a new tab in the default domain
	{ key = "t", mods = "SHIFT|CMD", action = act.SpawnTab("CurrentPaneDomain") },
	-- Toggle fullscreen
	{
		key = "Enter",
		mods = "CMD|OPT",
		action = wezterm.action.ToggleFullScreen,
	},
	-- Move between tabs
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "LeftArrow",
		mods = "CMD|SHIFT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CMD|SHIFT",
		action = act.MoveTabRelative(1),
	},
}

-- and finally, return the configuration to wezterm
return config
