#!/bin/bash

WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.title == "tmux") | .address' | head -n1)

if [ -n "$WINDOW" ]; then
    hyprctl dispatch focuswindow "address:$WINDOW"
else
    uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux a 2>/dev/null || tmux
fi
