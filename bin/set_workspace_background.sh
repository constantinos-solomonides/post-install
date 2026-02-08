#!/bin/bash
# File used to set the XFCE background to a random gallery, that changes over time
#
# Important background information
# * This is used to change the backgrounds for XFCE DM
# * Changes are applied to all workspaces
# * It uses xfconf-query to apply changes
# * The background galleries are expected to reside under /usr/share/background/<letter_or_digit>
#   Where digits are 0..9 and letters are a..z and A..Z but skipping every other, so a,c,e..z and A,C,E..Z
# * The colors and gradient are well known and locked-in
# * The background image changes randomly every 1 minute
# * There is no seeding or setting to a specific folder otherwise
# * The changes are applied to **all** monitors at once (No way to isolate)

# Make issues very visible and ensure they immediately stop execution
set -uxe

# Allow dry-run by setting "E" to "echo"
E=${E:-}

# Channel to use
CHANNEL=xfce4-desktop
# Apply the changes to all workspaces
$E xfconf-query -c "${CHANNEL}" -p /backdrop/single-workspace-mode -s true
# Get all monitors that are currently active
MONITORS=( $(xrandr --listactivemonitors | awk '{if(NR >= 2) {print $NF}}') )
# Get the ID of the unified workspace
WORKSPACE=$(xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-number)

# For EACH monitor
for MONITOR in ${MONITORS[*]}; do
    # Property to set (differs for each monitor)
    PROPERTY=/backdrop/screen0/monitor"${MONITOR}"/workspace"${WORKSPACE}"
    # Deactivate command execution output to reduce noise
    set +x
    BASE=$(
        # For every directory that contains background do the following:
        #   * Get a single random byte
        #   * Print it as a decimal number (-An disables address prefix for OD)
        #   * Prefix the directory
        # Then for that output
        #   * Sort the result numerically
        #   * Print only the first line
        #   * Print the value of the directory
        for i in /usr/share/backgrounds/{{a..z..2},{A..Z..2},{0..9}} ; do
            dd if=/dev/urandom bs=1 count=1 status=none   |
            od -An -t d  |
            xargs -L1 -I{}  echo -n "{} "; echo $i;
        done  | \
        sort -n  | \
        head -n 1  | \
        awk '{print $2}')
    # Reactivate command execution output to reduce noise
    set -x
    # Set the first background to be the first file found in that directory
    FILE="${BASE}"/$(ls --color=never $BASE | head -n 1)

    # Set the values
    #   Set the background to be the first file in the chose directory
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/last-image -s "${FILE}"
    #   Enable background rotation
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/backdrop-cycle-enable -n -t bool -s true
    #   Make the rotation delay to be counted in minutes
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/backdrop-cycle-period -n -t int -s 1
    #   Set the delay for the rotation to three (3) units (minutes)
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/backdrop-cycle-timer -n -t int -s 3
    #   Enable random ordering of backgrounds
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/backdrop-cycle-random-order -n -t bool -s true
    #   Set picture zoom to "Scaled"
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/image-style -s 4
    #   Set color style to vertical gradient
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/color-style -s 2
    #   Pick the first color of the two in the gradient
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/rgba1 \
        -n -t double -t double -t double -t double -s 0.560784 -s 0.349020 -s 0.007843 -s 1.000000
    #   Pick the second color of the two in the gradient
    $E xfconf-query -c "${CHANNEL}" -p "${PROPERTY}"/rgba2 \
        -n -t double -t double -t double -t double -s 0.929412 -s 0.831373 -s 0.000000 -s 1.000000
done
