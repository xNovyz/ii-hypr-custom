-- Look, feel, and input ported from the previous Hyprland config

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 5,
        border_size = 1,
        resize_on_border = true,
        allow_tearing = true,
        layout = "dwindle",
    },
    decoration = {
        rounding = 8,
        rounding_power = 2,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = false,
            xray = false,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false,
        vrr = 0,
    },
    cursor = {
        no_hardware_cursors = false,
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        force_no_accel = true,
        accel_profile = "flat",
        mouse_refocus = false,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.curve("ease", { type = "bezier", points = {{0.25, 0.1}, {0.25, 1.0}} })
hl.curve("overshot", { type = "bezier", points = {{0.05, 0.9}, {0.1, 1.05}} })
hl.curve("smoothOut", { type = "bezier", points = {{0.36, 0}, {0.66, -0.56}} })
hl.curve("smoothIn", { type = "bezier", points = {{0.25, 1}, {0.5, 1}} })
hl.curve("softOvershot", { type = "bezier", points = {{0.05, 0.9}, {0.1, 1.01}} })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 6, bezier = "smoothOut", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "smoothIn", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "smoothIn" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "softOvershot", style = "slidevert" })

-- Optional: per-device mouse tweak (uncomment / rename if you have this device)
-- hl.device({
--     name = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })
