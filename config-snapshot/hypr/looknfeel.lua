-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- No gaps between windows or borders.
    gaps_in = 7,
    gaps_out = 7,
    border_size = 0,


    -- Change to niri-like side-scrolling layout.
    --  layout = "scrolling",
  },
  decoration = {
    rounding = 0,
    dim_inactive = true,
    dim_strength = 0.15,
    blur = {
      enabled = true,
      size = 7,
      passes = 3,
      popups = true,
      popups_ignorealpha = 0.01,
      new_optimizations = true,
      ignore_opacity = false,
      xray = false,
      noise = 0.02,
      contrast = 1.0,
      brightness = 0.9,
      vibrancy = 0.2,
      vibrancy_darkness = 0.0,
    },
  },
})

-- Keep compositor opacity solid; terminals supply their own background alpha.
o.window(".*", { opacity = "1 override 1 override 1 override" })
o.window("com.mitchellh.ghostty", {
  opacity = "1 override 1 override 1 override",
  no_blur = false,
  xray = true,
})
-- Also cover applications that paint explicit opaque terminal-cell backgrounds.
o.window("^(foot|footclient)$", {
  opacity = "0.80 override 0.80 override 0.80 override",
  no_blur = false,
  xray = true,
})
o.window({ class = "^org.omarchy.agent$", initial_title = "^foot$" }, {
  opacity = "0.80 override 0.80 override 0.80 override",
  no_blur = false,
  xray = true,
})
-- Omarchy launches Ghostty TUIs with their own app IDs.
o.window({ tag = "terminal" }, { no_blur = false, xray = true, border_size = 0 })

-- Blur the Quickshell bar and its separate widget-tooltip popup surfaces.
hl.layer_rule({
  match = { namespace = "^omarchy-bar$" },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.01,
  xray = true,
})

-- Tooltips on other Omarchy layer-shell panels also inherit popup blur.
hl.layer_rule({
  match = { namespace = "^omarchy-keyboard-panel$" },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.01,
  xray = false,
})

hl.layer_rule({
  match = { namespace = "^omarchy-.*$" },
  blur_popups = true,
})

-- Blur only menu/clipboard/emoji cards; their full-screen backdrop is transparent.
hl.layer_rule({
  match = { namespace = "^omarchy-(menu|clipboard|emojis)$" },
  blur = true,
  blur_popups = true,
  ignore_alpha = 0.01,
  xray = false,
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
-- hl.config({
--   decoration = {
--     -- Use round window corners.
--     rounding = 8,
--
--     -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).

--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })
