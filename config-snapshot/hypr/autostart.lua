-- Extra autostart processes.
-- o.launch_on_start("my-service")
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl setcursor Bibata-Original-Classic 18")
end)
-- Start with night light enabled at the bar widget's preferred temperature.
o.launch_on_start("hyprsunset --temperature 5500")
