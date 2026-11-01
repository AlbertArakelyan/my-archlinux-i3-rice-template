#!/usr/bin/env bash
# Rofi power menu — Catppuccin Mocha
lock="  Lock"
logout="󰍃  Logout"
reboot="󰜉  Reboot"
shutdown="  Shutdown"

chosen=$(printf '%s\n' "$lock" "$logout" "$reboot" "$shutdown" | rofi -dmenu -i -p " " \
    -theme-str 'window { width: 280px; } listview { lines: 4; } mode-switcher { enabled: false; } entry { enabled: false; }')

confirm() {
    [ "$(printf 'No\nYes\n' | rofi -dmenu -i -p "$1?" \
        -theme-str 'window { width: 240px; } listview { lines: 2; } mode-switcher { enabled: false; } entry { enabled: false; }')" = "Yes" ]
}

case "$chosen" in
    "$lock")     i3lock -c 1e1e2e ;;
    "$logout")   confirm "Logout"   && i3-msg exit ;;
    "$reboot")   confirm "Reboot"   && systemctl reboot ;;
    "$shutdown") confirm "Shutdown" && systemctl poweroff ;;
esac
