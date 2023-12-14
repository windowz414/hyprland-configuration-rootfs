#!/bin/bash
# ------------------------------------------------------
# Setup
# ------------------------------------------------------
echo -e "${GREEN}"
cat <<"EOF"
 _  __          _                         _ 
| |/ /___ _   _| |__   ___   __ _ _ __ __| |
| ' // _ \ | | | '_ \ / _ \ / _` | '__/ _` |
| . \  __/ |_| | |_) | (_) | (_| | | | (_| |
|_|\_\___|\__, |_.__/ \___/ \__,_|_|  \__,_|
          |___/                             
EOF
echo -e "${NONE}"

# Default layout and variants
keyboard_layout="us"

_setupKeyboardLayout() {
    echo ""
    echo "Start typing = Search, RETURN = Confirm, CTRL-C = Cancel"
    keyboard_layout=$(localectl list-x11-keymap-layouts | gum filter --height 15 --placeholder "Find your keyboard layout...")
    echo ""
    echo "Keyboard layout changed to $keyboard_layout"
    echo ""
    _confirmKeyboard
}

_confirmKeyboard() {
    echo "Current selected keyboard setup:"
    echo "Keyboard layout: $keyboard_layout"
    if gum confirm "Do you want proceed with this keyboard setup?" --affirmative "Proceed" --negative "Change" ;then
        return 0
    elif [ $? -eq 130 ]; then
        exit 130
    else
        _setupKeyboardLayout
    fi
}

if [ "$restored" == "1" ]; then
    echo "You have already restored your settings into the new installation."
else
    _confirmKeyboard
    
    cp .install/templates/keyboard.conf ~/hyprland-configuration-rootfs-versions/$version/hypr/conf/keyboard.conf

    SEARCH="KEYBOARD_LAYOUT"
    REPLACE="$keyboard_layout"
    sed -i "s/$SEARCH/$REPLACE/g" ~/hyprland-configuration-rootfs-versions/$version/hypr/conf/keyboard.conf

    echo ""
    echo "Keyboard setup updated successfully."
    echo "PLEASE NOTE: You can update your keyboard layout later in ~/hyprland-configuration-rootfs/hypr/conf/keyboard.conf"
fi
