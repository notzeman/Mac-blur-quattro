#!/bin/bash
set -euo pipefail

theme_file="$HOME/.local/state/omarchy/current/theme/colors.toml"
target="$HOME/.config/hypr/hyprlock/colors.conf"

theme_color() {
    local color
    color=$(omarchy-theme-color --file "$theme_file" "$1" 2>/dev/null)
    [[ $color =~ ^#[[:xdigit:]]{6}$ ]] || return 1
    printf '%s' "${color#\#}"
}

foreground=$(theme_color foreground)
background=$(theme_color background)
accent=$(theme_color accent)
temporary=$(mktemp "${target}.XXXXXX")
trap 'rm -f "$temporary"' EXIT
printf '# Active Omarchy theme palette.\n$lock_foreground = rgb(%s)\n$lock_muted = rgba(%saa)\n$lock_accent = rgb(%s)\n$lock_surface = rgba(%s8c)\n' \
    "$foreground" "$foreground" "$accent" "$background" > "$temporary"
mv "$temporary" "$target"
