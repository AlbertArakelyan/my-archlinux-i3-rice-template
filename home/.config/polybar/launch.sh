#!/usr/bin/env bash
# Restart polybar on every i3 (re)load
polybar-msg cmd quit >/dev/null 2>&1
killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.2; done
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
