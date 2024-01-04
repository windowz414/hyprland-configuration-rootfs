# library.sh

# Some colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Function to display completion message
_displayCompletionMessage() {
    echo -e "${GREEN}"
    figlet "Done"
    echo -e "${NONE}"

    echo "Open ~/.config/hypr/hyprland.conf to check your new initial Hyprland configuration."
    echo ""
}

_copyConfigFiles() {
    if gum confirm "DO YOU WANT TO COPY THE PREPARED dotfiles INTO .config? (YOU CAN ALSO DO THIS MANUALLY)" ;then
        rsync -a -I .config ~/
        rsync -a -I .hushlogin ~/
        rsync -a -I .zprofile ~/
        rsync -a -I .zsh_aliases ~/
        rsync -a -I .zshrc
        rsync -a -I .wallpaper ~/
        rsync -a -I .local ~/
        rsync -a -I .current_wallpaper ~/
        echo ""
        echo ":: Configuration files successfully copied to ~/.config/"
        echo ""
    elif [ $? -eq 130 ]; then
        exit 130
    else
        echo ""
        echo "Installation canceled."
        echo "PLEASE NOTE: Open ~/.config/hypr/hyprland.conf to change your keyboard layout (default is us) and your screen resolution (default is preferred) if needed."
        echo "Then reboot your system!"
        exit;
    fi
}

