# CentOS Auto-Configuration Script

This script configures a fresh CentOS machine to set up development tools, Neovim with a custom configuration, SSH access, and additional dependencies. The script also disables SELinux temporarily, installs Rust, Tree-sitter, and Python dependencies, and configures shared libraries to ensure compatibility with Neovim.

## Features

- Updates the system and installs EPEL release
- Installs essential development tools, including Neovim, Git, and Python
- Sets up Neovim configuration from [RyanBlaney/nvim-config](https://github.com/RyanBlaney/nvim-config)
- Installs and configures Rust and Tree-sitter for Neovim parsing and syntax highlighting
- Enables and configures SSH for remote access
- Optionally sets up cockpit socket for web-based system management

## Requirements

- CentOS operating system
- Root or sudo access

## Installation

1. **Download the Script:**
   Save the following script to a file named `centos-setup.sh`.
```bash
curl -o centos-setup.sh https://raw.githubusercontent.com/RyanBlaney/CentOS-Setup/main/centos-setup.sh
```

2. **Make the Script Executable:**
```bash
chmod +x centos-setup.sh
```
3. **Run the script:**
```bash
sudo ./centos-setup.sh
```
