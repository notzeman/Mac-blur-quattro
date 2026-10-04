# Mac-blur-quattro

A dark, Mac-inspired glass theme for Omarchy Quattro, based on the
Nord Night palette and a complete saved desktop configuration.

![Theme preview](preview.png)

## Install

Requires Omarchy 4.x with Lua-configured Hyprland.

```bash
omarchy theme install https://github.com/notzeman/Mac-blur-quattro
```

## Activate

```bash
omarchy theme set Mac-blur-quattro
```

## Appearance

- Theme-relative colors from `colors.toml`, with no fixed terminal tint.
- Native Omarchy bar at 35% opacity, with the tray on the right.
- Popup panels and hover tooltips at 55% opacity, with no outer borders.
- Omarchy root and system menus at 55% opacity, with blurred borderless cards.
- Clipboard and emoji cards use the same blur, with a clear desktop outside them.
- Hyprland blur size 7 with 3 passes.
- Ghostty at font size 10 and 55% background opacity.
- White Ghostty cursor and animated white GLSL trail.
- LookElsewhere in the center: 25-minute focus intervals, 20-second breaks,
  and a 3-minute long break every fourth break.
- Bibata Original Classic pointer at size 18.
- Night light starts at 5500K.
- Wolfykq-inspired Hyprlock layout with a 12-hour clock, no seconds, and blurred wallpaper.

The theme uses Omarchy's generated application palettes. Its shell surface
colors refer to palette roles, so edits to `colors.toml` remain dynamic.

## Saved configuration

`config-snapshot/` contains the current working user configuration, including
the latest menu and clipboard blur fixes:

- `ghostty/`: terminal configuration, appearance override, and white trail shader.
- `hypr/`: personal Hyprland configuration, blur rules, bindings, and autostart.
- `hypr/hyprlock.conf` and `hypr/hyprlock/`: modular lock layout and theme-aware helper scripts.
- `omarchy/shell.json`: native-bar layout and plugin settings.
- `omarchy/plugins/zaman.lock/`: Hyprlock adapter for Omarchy's manual, idle, and suspend lock IPC.
- `omarchy/themed/shell.toml.tpl`: global shell appearance template.
- `omarchy/hooks/theme-set.d/99-bibata-pointer.sh`: mouse-pointer preference.
- `gtk-3.0/` and `gtk-4.0/`: mouse-pointer settings.
- `xdg-terminals.list`: Ghostty as the default terminal.

Selecting the theme applies its palette, wallpapers, and shell appearance.
The saved Hyprland and Ghostty files provide the rest of the setup.

### Apply the saved appearance configuration

Copy `config-snapshot/ghostty/` to `~/.config/ghostty/` for font size 10,
55% transparency, and the white cursor-trail shader. Paths use `~/` so they
work with any username.

Copy or merge `config-snapshot/hypr/looknfeel.lua` into your personal
`~/.config/hypr/looknfeel.lua` to enable the included terminal, bar, flyout,
menu, clipboard, and emoji blur rules. Omarchy's main Hyprland config must
load this module with `require("hypr.looknfeel")`.

`config-snapshot/omarchy/shell.json` contains the bar layout and plugin settings.
The remaining snapshot files provide the pointer settings, night-light
autostart, keyboard shortcuts, and original monitor/input preferences.

Apply changes with:

```bash
omarchy default terminal ghostty
hyprctl reload
hyprctl configerrors
omarchy restart terminal
omarchy restart shell
```

Ghostty, hyprsunset, hyprlock, the Bibata Original Classic cursor theme, and the third-party
plugins referenced in `shell.json` need to be installed separately. Plugin
source other than the included Hyprlock adapter, packages, clipboard history,
and scheduler state are not bundled.

### Hyprlock

The layout is adapted from
[wolfykq/dotfiles](https://github.com/wolfykq/dotfiles/tree/main/.config/hypr).
It retains the centered time, date, and password-field arrangement, with
installed-font fallbacks and a media label positioned to fit different outputs.

Copy `config-snapshot/hypr/hyprlock.conf` and `config-snapshot/hypr/hyprlock/`
into `~/.config/hypr/`, and copy the included `zaman.lock` directory into
`~/.config/omarchy/plugins/`. Then enable its supported built-in lock clone:

```bash
omarchy plugin enable zaman.lock
omarchy restart shell
```

**Super+Ctrl+L**, `omarchy system lock`, the System menu, idle locking, and
suspend locking use this adapter. The clock displays `03:45 PM`, without
seconds. Hyprlock applies its own background blur with size 7 and 3 passes;
it uses the current Omarchy wallpaper and refreshes palette colors before
every lock. The optional media label uses `playerctl` when available.

## Wallpapers

Theme wallpapers are in `backgrounds/`, numbered `00.png` through `21.png` in
alphabetical order of their original filenames. After adding or renaming files
there, refresh the active theme and picker cache:

```bash
omarchy theme refresh
omarchy theme bg cache
```

For additions that should appear without refreshing the theme, use
`~/.config/omarchy/backgrounds/mac-blur-quattro/`.
