#!/usr/bin/env bash
CONFIG_PATH="$HOME/.config/niri/config.kdl"

# Check if transform "270" is currently commented out
if grep -q '^[[:space:]]*\/\/[[:space:]]*transform "270"' "$CONFIG_PATH"; then
    # --- SWITCH TO VERTICAL ---
    # Strip '//' in front of transform "270"
    sed -i '/transform "270"/s|//[[:space:]]*transform|transform|' "$CONFIG_PATH"

    niri msg action reload-config

    obs-cmd replay stop
    sleep 1.5
    obs-cmd profile switch vert
    sleep 3
    obs-cmd scene switch vert
    sleep 1
    obs-cmd replay start
else
    # --- SWITCH TO NORMAL ---
    # Add '//' in front of transform "270" if it isn't already commented
    sed -i '/^[[:space:]]*transform "270"/s|transform "270"|//    transform "270"|' "$CONFIG_PATH"

    niri msg action reload-config

    obs-cmd replay stop
    sleep 1.5
    obs-cmd profile switch norm
    sleep 3
    obs-cmd scene switch norm
    sleep 1
    obs-cmd replay start
fi
