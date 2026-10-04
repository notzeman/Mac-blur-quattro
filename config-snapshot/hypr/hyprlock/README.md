# Hyprlock for Mac-blur-quattro

Adapted from [wolfykq/dotfiles](https://github.com/wolfykq/dotfiles/tree/main/.config/hypr).

- Large centered clock in 12-hour format with AM/PM and no seconds.
- Centered date and password field; optional media label near the bottom.
- Current Omarchy wallpaper, blurred using size 7 and 3 passes.
- Palette regenerated from the active Omarchy theme before each lock.
- Uses JetBrainsMono Nerd Font, already installed on this desktop.

Omarchy's lock IPC is supplied by the user-owned `zaman.lock` plugin, which
launches Hyprlock and reports compositor lock status to Omarchy's existing
manual, idle, and suspend lock callers.

Lock using **Super+Ctrl+L** or `omarchy system lock`.
