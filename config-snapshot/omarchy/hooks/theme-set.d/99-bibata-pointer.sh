#!/bin/bash
set -e

# Preserve the personal mouse pointer when Omarchy changes themes.
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Original-Classic'
gsettings set org.gnome.desktop.interface cursor-size 18
hyprctl setcursor Bibata-Original-Classic 18
