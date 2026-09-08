-- Desktop-only autostart (from the main PC). Copy over hypr/custom/execs.lua if needed.

hl.on("hyprland.start", function()
    hl.exec_cmd("easyeffects --hide-window --service-mode")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("surge server start")
    hl.exec_cmd("systemctl --user start sunshine.service")
end)
