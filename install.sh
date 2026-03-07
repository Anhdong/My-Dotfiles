#!/bin/bash

# Exit on error
set -e

echo "Starting dotfiles installation..."

# --- Configuration ---

# Custom repo address
REPOS=(
    #codium
    https://download.opensuse.org/repositories/home:Mx775/openSUSE_Tumbleweed/home:Mx775.repo
)

# List of packages to install
PACKAGES=(
    #Font
    jetbrains-mono-fonts
    symbols-only-nerd-fonts
    
    #TUI
    impala
    bluetui

    #package for installation
    git
    gh
    stow
    
    #essential
    tlp
    7zip
    bluez
    mpv
    imv
    fcitx5

    #default software
    codium
    yazi
    zen-browser

    #others
    fastfetch
    btop
    gemini-cli
    #flatpak
    
)

# --- Execution ---


# Add repositories from the array
for repo in "${REPOS[@]}"; do
    echo "Adding repository: $repo"
    sudo zypper addrepo "$repo"
done


# Refresh and auto-import keys
echo "Refreshing repositories..."
sudo zypper --gpg-auto-import-keys refresh




# Install packages
echo "Installing packages with zypper..."
sudo zypper --no-recommends install -y "${PACKAGES[@]}"




# Link dotfiles with stow
echo "Linking dotfiles with stow..."
# Ensure we are in the script's directory
cd "$(dirname "$0")"
stow -v -R .





echo "Installation complete!"
