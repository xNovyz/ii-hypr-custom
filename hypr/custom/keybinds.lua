require("hyprland.lib")
require("hyprland.variables")
if is_file_exists(HOME .. "/.config/hypr/custom/variables.lua") then
    require("custom.variables")
end

local settingsPanel = "qs -p $HOME/.config/quickshell/$qsConfig/settings.qml"

local function bind(key, action, description)
    if description then
        hl.bind(key, action, { description = description })
    else
        hl.bind(key, action)
    end
end

-- II often stacks quickshell + fallback exec on the same key; unbind repeatedly.
local function rebind(key, action, description)
    for _ = 1, 6 do
        hl.unbind(key)
    end
    bind(key, action, description)
end

-- Ambxst-style shell binds (mapped to Illogical Impulse quickshell globals)
rebind("SUPER + Z", hl.dsp.global("quickshell:searchToggle"), "Shell: Launcher / search")
rebind("SUPER + D", hl.dsp.global("quickshell:overlayToggle"), "Shell: Dashboard")
rebind("SUPER + SHIFT + D", hl.dsp.global("quickshell:sidebarLeftToggle"), "Shell: Assistant")
rebind("SUPER + T", hl.dsp.exec_cmd("kitty -e tmux new-session -A -s main"), "Shell: Tmux")
rebind("SUPER + B", hl.dsp.global("quickshell:wallpaperSelectorToggle"), "Shell: Wallpapers")
rebind("SUPER + Escape", hl.dsp.global("quickshell:sessionToggle"), "Shell: Power menu")
rebind("SUPER + SHIFT + C", hl.dsp.exec_cmd(settingsPanel), "Shell: Config")
rebind("SUPER + E", hl.dsp.global("quickshell:cheatsheetToggle"), "Shell: Tools / cheatsheet")
rebind("SHIFT + CTRL + S", hl.dsp.global("quickshell:regionScreenshot"), "Utilities: Screenshot")
rebind("SUPER + ALT + B", hl.dsp.exec_cmd("killall ydotool qs quickshell; qs -c $qsConfig &"), "Shell: Reload quickshell")
rebind("SUPER + CTRL + ALT + B", hl.dsp.exec_cmd("pkill -f 'qs -c $qsConfig'"), "Shell: Quit quickshell")
rebind("SUPER + SHIFT + Z", hl.dsp.exec_cmd("hyprctl dispatch workspace e-1"), "Workspace: Previous")
rebind("SUPER + SHIFT + X", hl.dsp.exec_cmd("hyprctl dispatch workspace e+1"), "Workspace: Next")
rebind("SUPER + SHIFT + Tab", hl.dsp.exec_cmd("hyprctl dispatch workspace -1"), "Workspace: Previous (history)")

-- Disable Super-alone actions (II search-on-release and workspace-number jump)
for _ = 1, 2 do
    hl.unbind("SUPER + SUPER_L")
    hl.unbind("SUPER + SUPER_R")
end
for _ = 1, 2 do
    hl.unbind("SUPER_L")
    hl.unbind("SUPER_R")
end
hl.unbind("SUPER_L", { release = true })
hl.unbind("SUPER_R", { release = true })

-- Previous Hyprland app binds
rebind("SUPER + X", hl.dsp.exec_cmd(terminal), "App: Terminal")
rebind("SUPER + F", hl.dsp.exec_cmd(fileManager), "App: File manager")
rebind("SUPER + C", hl.dsp.exec_cmd(browser), "App: Browser")
rebind("SUPER + N", hl.dsp.exec_cmd("kitty -e cava"), "App: Cava visualizer")
rebind("SUPER + R", hl.dsp.global("quickshell:sidebarRightToggle"), "Shell: Quick toggles / right sidebar")

-- Previous window management binds
rebind("SUPER + H", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), "Window: Fullscreen")
rebind("SUPER + W", hl.dsp.window.float({ action = "toggle" }), "Window: Float/tile")
rebind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"),
    "Session: Exit Hyprland")
rebind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:special", follow = true }),
    "Window: Move to scratchpad")

-- Workspace focus (Super+1..0) stays on II defaults; restore old move-window binds (Super+Shift+1..0)
for i = 1, 10 do
    local key = i % 10
    rebind("SUPER + SHIFT + " .. key, function()
        hl.dispatch(hl.dsp.window.move({ workspace = workspace_in_group(i), follow = true }))
    end, "Window: Move to workspace " .. i)
end

-- Window focus / move with arrows (from old config; II defaults, re-bound to survive overrides)
for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local focusdir = { "l", "r", "u", "d" }
    rebind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }),
        "Window: Focus " .. arrowkey[i])
    rebind("SUPER + SHIFT + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }),
        "Window: Move " .. arrowkey[i])
end

rebind("SUPER + S", hl.dsp.workspace.toggle_special("special"), "Workspace: Toggle scratchpad")

for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local resize = { "-50 0", "50 0", "0 -50", "0 50" }
    rebind("SUPER + ALT + " .. arrowkey[i], hl.dsp.exec_cmd("hyprctl dispatch resizeactive " .. resize[i]),
        "Window: Resize " .. arrowkey[i])
end

rebind("CTRL + SUPER + ALT + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"),
    "Edit user keybinds")
