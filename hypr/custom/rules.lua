-- Window rules ported from the previous Hyprland config

hl.window_rule({ match = { class = "^Badlion Minecraft Client.*$" }, immediate = true })

hl.window_rule({ match = { class = "^feishin$" }, opacity = 0.85 })
hl.window_rule({ match = { class = "^org.gnome.Nautilus$" }, opacity = 0.75 })
hl.window_rule({ match = { class = "^elecwhat$" }, opacity = 0.75 })
hl.window_rule({ match = { class = "^teamspeak-client$" }, opacity = 0.95 })
hl.window_rule({ match = { class = "^firefox$" }, opacity = 0.98 })
hl.window_rule({ match = { class = "^zen$" }, opacity = 0.98 })
hl.window_rule({ match = { class = "^org.telegram.desktop$" }, opacity = 0.90 })

hl.window_rule({ match = { class = "^GLava$" }, float = true })
hl.window_rule({ match = { class = "^GLava$" }, pin = true })
hl.window_rule({ match = { class = "^GLava$" }, no_blur = true })
hl.window_rule({ match = { class = "^GLava$" }, no_focus = true })
hl.window_rule({ match = { class = "^GLava$" }, no_shadow = true })
hl.window_rule({ match = { class = "^GLava$" }, border_size = 0 })
-- Monitor-specific GLava rules (desktop only) — set titles/outputs on the laptop if needed:
-- hl.window_rule({ match = { class = "^GLava$", title = "^GLava-DP1$" }, monitor = "DP-1" })
-- hl.window_rule({ match = { class = "^GLava$", title = "^GLava-DP3$" }, monitor = "DP-3" })
