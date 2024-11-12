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

# Remove entries from bashrc if they were added during setup
sed -i '/export PATH=".*\/.cargo\/bin:$PATH"/d' ~/.bashrc

echo "All temporary packages and configurations have been removed."

