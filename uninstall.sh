#!/bin/bash

# Uninstall Neovim, Lua, and development tools
sudo yum remove -y \
  neovim \
  git \
  openssh-server \
  python3 \
  python3-pip \
  xclip \
  wget \
  cmake \
  policycoreutils-python-utils \
  ncurses-devel \
  luarocks

# Remove Rust and related directories
rm -rf ~/.cargo ~/.rustup tree-sitter

# Remove the Neovim installation and configuration
sudo rm -rf /usr/local/nvim
sudo rm -f /usr/local/bin/nvim
rm -rf ~/.config/nvim

# Clean up any unused dependencies and cached files
sudo yum autoremove -y
sudo yum clean all

# Check if Docker is installed
if command -v docker >/dev/null 2>&1; then
    # Option to remove Docker
    read -p "Would you like to remove Docker? y/N: " response

    # Check if the response is "y", "Y", "yes", or "YES"
    if [[ "$response" =~ ^(y|Y|yes|YES)$ ]]; then
        echo "Removing Docker..."

        # Attempt to remove Docker components and check if successful
        if sudo yum remove -y docker-ce docker-ce-cli containerd.io; then
            # Disable Docker service to prevent it from starting again
            sudo systemctl disable docker >/dev/null 2>&1
            
            echo "Docker removed successfully!"
        else
            echo "Error: Docker removal failed. Please check your package manager and try again."
            exit 1
        fi
    else
        echo "Docker removal skipped."
    fi
else
    echo "Docker is not installed. No removal necessary."
fi


# Remove entries from bashrc if they were added during setup
sed -i '/export PATH=".*\/.cargo\/bin:$PATH"/d' ~/.bashrc

echo "All temporary packages and configurations have been removed."

