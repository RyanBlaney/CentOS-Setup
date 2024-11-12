#!/bin/bash

# Update system and install EPEL release
sudo yum install -y epel-release
sudo yum update -y

# Install basic development tools and utilities
sudo yum install -y \
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

# Set up Python and Neovim dependencies
pip3 install --user pynvim

# Enable and start SSH service
sudo systemctl enable --now sshd
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# Install Rust and Tree-sitter
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
git clone https://github.com/tree-sitter/tree-sitter
cd tree-sitter/cli
cargo install --path .
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
cd ~

# Download and install Neovim 0.10
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/local/nvim
sudo ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

# Clone Neovim configuration from GitHub
mkdir -p ~/.config
cd ~/.config
git clone https://github.com/RyanBlaney/nvim-config.git nvim

# Set up additional Neovim dependencies
sudo luarocks install luv

# Ensure that symbolic links are set for shared libraries
sudo ldconfig

# Add docker
read -p "Would you like to install docker? y/N: " response

if [[ "$response" =~ ^(y|Y|yes|YES)$ ]]; then
  echo "Installing Docker..."
  
  # Add Docker repository
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  
  # Install Docker
  sudo yum install -y docker-ce docker-ce-cli containerd.io
  
  # Start and enable Docker service
  sudo systemctl start docker
  sudo systemctl enable docker
  
  echo "Docker installed successfully!"
else
  echo "Docker installation skipped."
fi

# Enable and configure additional services (if needed)
echo "To access the internet, run 'sudo systemctl enable --now cockpit.socket'"

echo "Configuration completed. Please restart the terminal or source ~/.bashrc for environment updates."

