# Illogical Impulse — custom Hyprland overlays

Portable copy of the Ambxst-style Hyprland customizations used with
[Illogical Impulse](https://github.com/end-4/dots-hyprland): keybinds, apps,
look-and-feel, window rules, and light autostart.

Designed to drop onto a laptop (or any other machine) that already has II installed.

## Prerequisites

1. Illogical Impulse installed and working (`~/.config/hypr/hyprland.lua` present)
2. Hyprland using the Lua config (not a stub `hyprland.conf`)
3. Quickshell config `ii` available (`qs -c ii`)

## Quick start

```bash
git clone <this-repo> ~/ii-hypr-custom
cd ~/ii-hypr-custom
chmod +x apply.sh
./apply.sh
```

That will:

1. Back up any existing `~/.config/hypr/custom/` under `~/.config/hypr/backups/`
2. Install the files from `hypr/custom/`
3. Run `hyprctl reload` if available

### Useful flags

```bash
./apply.sh --dry-run          # preview only
./apply.sh --keybinds-only    # only keybinds.lua + variables.lua
./apply.sh --no-execs         # skip autostart
./apply.sh --no-reload        # don't call hyprctl reload
```

## What's included

| File | Purpose |
|------|---------|
| `hypr/custom/keybinds.lua` | Ambxst-style binds + window/workspace management |
| `hypr/custom/variables.lua` | `terminal` / `fileManager` / `browser` |
| `hypr/custom/general.lua` | Gaps, rounding, blur, animations, input |
| `hypr/custom/env.lua` | Wayland / cursor env vars |
| `hypr/custom/rules.lua` | Opacity + GLava rules (portable) |
| `hypr/custom/execs.lua` | EasyEffects autostart (if installed) |
| `examples/execs.desktop.lua` | Desktop PC autostart (sunshine, surge, awww) |

**Not included:** `monitors.lua` (machine-specific). Configure monitors on the laptop with nwg-displays or II defaults.

## After applying

1. Edit `~/.config/hypr/custom/variables.lua` if your apps differ (e.g. no zen-browser)
2. See [KEYBINDS.md](KEYBINDS.md) for the bind map
3. Optional desktop autostart:  
   `cp examples/execs.desktop.lua ~/.config/hypr/custom/execs.lua`

## Restore

```bash
cp -a ~/.config/hypr/backups/custom-YYYYMMDD-HHMMSS/. ~/.config/hypr/custom/
hyprctl reload
```
