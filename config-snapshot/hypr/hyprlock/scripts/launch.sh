#!/bin/bash
set -euo pipefail
bash "$HOME/.config/hypr/hyprlock/scripts/update_colors.sh"
exec hyprlock --config "$HOME/.config/hypr/hyprlock.conf" --grace 0
