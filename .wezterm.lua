local wezterm = require("wezterm")

local config = {}

-- Use config builder if available
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- default terminal
config.default_prog = {
	"C:/Program Files/Git/bin/bash.exe",
	"--login",
	"-i",
}
-- =========================
-- Font
-- =========================
-- config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("MonaspiceRn Nerd Font")
config.font = wezterm.font("Maple Mono NF")
-- config.font_size = 11.5
config.font_size = 12

-- Enable ligatures
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- =========================
-- Color Scheme (Tokyonight)
-- =========================
config.color_scheme = "Tokyo Night"

-- Transparency (Windows 11 works best)
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0

-- Blur effect (Windows acrylic style)
config.win32_system_backdrop = "Acrylic"

-- =========================
-- Window Styling
-- =========================
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

config.window_decorations = "RESIZE"

-- =========================
-- Cursor Styling
-- =========================
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 600
config.cursor_thickness = 2

-- =========================
-- Tab Bar Styling
-- =========================
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.5

-- =========================
-- Scrollback
-- =========================
config.scrollback_lines = 5000

-- =========================
-- Performance
-- =========================
-- config.max_fps = 144
-- config.animation_fps = 144
-- config.front_end = "WebGpu"

return config
