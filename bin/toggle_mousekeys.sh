#!/bin/bash
# Assumptions:
#   * XFCE DE
#   * Ubuntu-based distro
#   * `xdotool` available and functional
#   * `xserver-xorg-input-synaptics` installed

#set -x
set -ue
# The proper value for this can be found by running `xfconf-query -c pointers -l`
property="/DELL07EA00_06CB7E92_Touchpad/Properties/Device_Enabled"
# Get the current state
current=$(xfconf-query -c pointers -p ${property})
# Invert it by XOR'ing it
next=$(( 1 ^ current))

# This is not strictly needed. It simply moves the cursor out of the way when inactive, and places it closer to the middle when activated
if [ "$next" != "0" ]; then
    mouse_location=( 400 400 )
else
    mouse_location=( 0 0 )
fi
xdotool mousemove ${mouse_location[@]}
# Set the touchpad activation state to the new one
synclient TouchpadOff=${current}
xfconf-query -c pointers -p ${property} -s ${next}
