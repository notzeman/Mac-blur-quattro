#!/bin/bash
set -euo pipefail

# Read Omarchy's normalized palette, not the obsolete .config/current path
# or raw color0 keys that are absent in several third-party themes.
theme_file="$HOME/.local/state/omarchy/current/theme/colors.toml"
style_dir="$HOME/.config/omarchy/gtk"
mkdir -p "$style_dir"

theme_color() {
  local value
  value=$(omarchy-theme-color --file "$theme_file" "$1" 2>/dev/null)
  [[ $value =~ ^#[[:xdigit:]]{6}$ ]] || {
    printf 'GTK theme: invalid %s color: %s\n' "$1" "$value" >&2
    return 1
  }
  printf '%s' "$value"
}

background=$(theme_color background)
foreground=$(theme_color foreground)
accent=$(theme_color accent)
red=$(theme_color red)
green=$(theme_color green)
yellow=$(theme_color yellow)

temporary=$(mktemp "$style_dir/palette.css.XXXXXX")
trap 'rm -f "$temporary"' EXIT
cat > "$temporary" <<EOF
/* Generated from the active Omarchy theme. */
@define-color window_bg_color $background;
@define-color window_fg_color $foreground;
@define-color view_bg_color $background;
@define-color view_fg_color $foreground;
@define-color headerbar_bg_color $background;
@define-color headerbar_fg_color $foreground;
@define-color sidebar_bg_color $background;
@define-color sidebar_fg_color $foreground;
@define-color dialog_bg_color $background;
@define-color dialog_fg_color $foreground;
@define-color popover_bg_color $background;
@define-color popover_fg_color $foreground;
@define-color card_bg_color $background;
@define-color card_fg_color $foreground;
@define-color accent_bg_color $accent;
@define-color accent_fg_color $background;
@define-color accent_color $accent;
@define-color destructive_color $red;
@define-color destructive_bg_color $red;
@define-color destructive_fg_color $background;
@define-color success_color $green;
@define-color warning_color $yellow;
@define-color error_color $red;
@define-color theme_bg_color $background;
@define-color theme_fg_color $foreground;
@define-color theme_base_color $background;
@define-color theme_text_color $foreground;
@define-color theme_selected_bg_color $accent;
@define-color theme_selected_fg_color $background;
EOF
mv "$temporary" "$style_dir/palette.css"

mode=$(omarchy-theme-color --file "$theme_file" mode 2>/dev/null)
if [[ $mode == light ]]; then
  gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3
  gsettings set org.gnome.desktop.interface color-scheme prefer-light
else
  gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
  gsettings set org.gnome.desktop.interface color-scheme prefer-dark
fi

printf 'GTK palette and glass popup styling refreshed.\n'
