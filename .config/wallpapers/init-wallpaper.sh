#!/bin/bash
WALLPAPER_DIR="$HOME/.config/wallpapers"
INDEX_FILE="$HOME/.config/wallpapers/.wallpaper_index"

mapfile -t walls < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | sort)
count=${#walls[@]}
[ "$count" -eq 0 ] && exit 1

idx=0
[ -f "$INDEX_FILE" ] && idx=$(cat "$INDEX_FILE")

feh --bg-scale "${walls[$idx]}"
