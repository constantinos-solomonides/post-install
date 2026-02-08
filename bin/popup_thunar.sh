#!/bin/bash
# File used to give pop-up functionality to `Thunar` file browser
# Assumptions
#   * `xdtool` in installed and usable
#   * Thunar has `- Thunar` in its desktop title
#   * There's only one instance of Thunar running, with directories as tabs (otherwise only the first is impacted by this)

# Get which desktop Thunar belongs to
thunar_desktop="$(xdotool search --name '.*- Thunar' get_desktop_for_window 2>/dev/null)"
# Get the desktop the user is currently on
current_desktop=$(xdotool get_desktop)

# If Thunar isn't running start it
if [ -z "${thunar_desktop}" ]; then
    thunar
fi

# Get the Thunar desktop again (in case it changed)
thunar_desktop="$(xdotool search --name '.*- Thunar' get_desktop_for_window 2>/dev/null)"

# If Thunar is on a negative desktop (i.e. unmapped)
if  [ "${thunar_desktop}" -lt 0 ]; then
    # Get the window information
    #   map the window
    #   Bring it to the current desktop
    #   Focus it
    #   Activate it
    xdotool search --name '.*- Thunar' \
        windowmap \
        set_desktop_for_window "${current_desktop}" \
        windowfocus \
        windowactivate
# If Thunar is mapped but on another desktop
elif [ "${thunar_desktop}" -ne "${current_desktop}" ]; then
    #   Bring it to the current desktop
    #   Focus it
    #   Activate it
    xdotool search --name '.*- Thunar' \
        set_desktop_for_window $(xdotool get_desktop) \
        windowfocus \
        windowactivate
# If Thunar is found on this desktop (because other instances didn't happen)
else
    # Unmap Thunar
    xdotool search --name '.*- Thunar' windowunmap
fi
