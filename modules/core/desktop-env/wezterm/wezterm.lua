local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'nord'

config.font = wezterm.font 'Fira Code Nerd Font'
config.font_size = 11

config.hide_tab_bar_if_only_one_tab = true
use_fancy_tab_bar = false

return config