#!/usr/bin/env bash
# Apply Illogical Impulse Hyprland custom overlays (keybinds, look, apps, rules).
# Requires: Illogical Impulse already installed (hyprland.lua sourcing custom/*).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_ROOT/hypr/custom"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/custom"
BACKUP_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

DRY_RUN=false
WITH_RULES=true
WITH_GENERAL=true
WITH_EXECS=true
WITH_ENV=true
RELOAD=true

usage() {
  cat <<'EOF'
Usage: ./apply.sh [options]

Installs this repo's hypr/custom/* into ~/.config/hypr/custom/
(after backing up any existing custom/ directory).

Options:
  --dry-run         Show what would be done, change nothing
  --keybinds-only   Only install keybinds.lua + variables.lua
  --no-rules        Skip rules.lua
  --no-general      Skip general.lua (gaps/blur/animations)
  --no-execs        Skip execs.lua (autostart)
  --no-env          Skip env.lua
  --no-reload       Do not run hyprctl reload
  -h, --help        Show this help

Examples:
  ./apply.sh
  ./apply.sh --keybinds-only
  ./apply.sh --dry-run
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    --keybinds-only)
      WITH_RULES=false
      WITH_GENERAL=false
      WITH_EXECS=false
      WITH_ENV=false
      ;;
    --no-rules) WITH_RULES=false ;;
    --no-general) WITH_GENERAL=false ;;
    --no-execs) WITH_EXECS=false ;;
    --no-env) WITH_ENV=false ;;
    --no-reload) RELOAD=false ;;
    -h|--help) usage; exit 0 ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

run() {
  if $DRY_RUN; then
    echo "DRY-RUN: $*"
  else
    "$@"
  fi
}

echo "==> Source: $SRC"
echo "==> Target: $DEST"

if [[ ! -f "$SRC/keybinds.lua" ]]; then
  echo "error: missing $SRC/keybinds.lua" >&2
  exit 1
fi

# Sanity: II Lua config should be present
if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprland.lua" ]]; then
  echo "warning: ~/.config/hypr/hyprland.lua not found."
  echo "         Install Illogical Impulse first, then re-run this script."
fi

FILES=(keybinds.lua variables.lua)
$WITH_ENV && FILES+=(env.lua)
$WITH_GENERAL && FILES+=(general.lua)
$WITH_RULES && FILES+=(rules.lua)
$WITH_EXECS && FILES+=(execs.lua)

# Backup existing custom tree if anything is there
if [[ -d "$DEST" ]] && [[ -n "$(ls -A "$DEST" 2>/dev/null || true)" ]]; then
  BACKUP_DIR="$BACKUP_ROOT/custom-$TIMESTAMP"
  echo "==> Backing up existing custom/ -> $BACKUP_DIR"
  run mkdir -p "$BACKUP_ROOT"
  run cp -a "$DEST" "$BACKUP_DIR"
fi

echo "==> Installing files:"
run mkdir -p "$DEST/scripts"
for f in "${FILES[@]}"; do
  echo "    $f"
  run cp -f "$SRC/$f" "$DEST/$f"
done

if [[ -f "$SRC/scripts/__restore_video_wallpaper.sh" ]]; then
  echo "    scripts/__restore_video_wallpaper.sh"
  run cp -f "$SRC/scripts/__restore_video_wallpaper.sh" "$DEST/scripts/__restore_video_wallpaper.sh"
  run chmod +x "$DEST/scripts/__restore_video_wallpaper.sh"
fi

echo
echo "==> Tip: edit $DEST/variables.lua if kitty/nautilus/zen-browser differ on this machine."

if $RELOAD; then
  if command -v hyprctl >/dev/null 2>&1; then
    echo "==> Reloading Hyprland"
    if $DRY_RUN; then
      echo "DRY-RUN: hyprctl reload"
    else
      hyprctl reload || echo "warning: hyprctl reload failed (not in a Hyprland session?)"
    fi
  else
    echo "==> hyprctl not found; skip reload (log out/in later)"
  fi
fi

echo
echo "Done. Keybind summary: see KEYBINDS.md"
echo "Restore backup with:  cp -a $BACKUP_ROOT/custom-YYYYMMDD-HHMMSS/. $DEST/"
