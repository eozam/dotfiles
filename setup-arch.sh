#!/bin/bash
clear

repo="eozam/dotfiles"

# Check if command exists
_checkCommandExists() {
    package="$1";
	if ! command -v $package > /dev/null; then
        return 1
    else
        return 0
    fi
}

# Update the system
echo "Updating the system..."
sudo pacman -Syu --noconfirm

# Install git and configure default branch to 'main'
echo "Installing git..."
sudo pacman -S --needed  --noconfirm git
git config --global init.defaultBranch main

# Install nano
echo "Installing nano..."
sudo pacman -S --needed  --noconfirm nano

# Install paru (AUR helper)
echo "Installing paru..."
if _checkCommandExists "paru"; then
    echo ":: paru is already installed"
else
    sudo pacman -S --needed  --noconfirm base-devel
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si --noconfirm
    cd ~
fi
echo

# Clean up
echo "Cleaning up..."
rm -rf /tmp/paru

echo "Setup complete!"
