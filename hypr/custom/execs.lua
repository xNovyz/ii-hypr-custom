-- Portable autostart for Illogical Impulse / Hyprland.
-- Machine-specific services (sunshine, surge, etc.) live in examples/.

hl.on("hyprland.start", function()
    hl.exec_cmd("command -v easyeffects >/dev/null 2>&1 && easyeffects --hide-window --service-mode")
end)
