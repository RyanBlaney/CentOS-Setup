# Use AlmaLinux 9 as the base image
FROM almalinux:latest

# Install EPEL and update the system
RUN dnf install -y epel-release && \
    dnf update -y

# Install basic development tools and utilities
RUN dnf install -y \
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

# Install Python Neovim dependencies
RUN pip3 install --user pynvim

# Install additional development tools if needed
RUN dnf groupinstall -y "Development Tools"

# Set up Rust and Tree-sitter CLI
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    source $HOME/.cargo/env && \
    git clone https://github.com/tree-sitter/tree-sitter && \
    cd tree-sitter/cli && \
    cargo install --path .

# Set environment variable for Rust
ENV PATH="$HOME/.cargo/bin:$PATH"

# Install Neovim 0.10
RUN wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && \
    mv nvim-linux64 /usr/local/nvim && \
    ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux64.tar.gz

# Install NodeJS 22
RUN curl -fsSL https://rpm.nodesource.com/setup_22.x | bash -
RUN dnf install -y nodejs

RUN mkdir -p ~/.config && \
    cd ~/.config && \
    git clone https://github.com/RyanBlaney/deployable-neovim-config.git nvim

# Clean up unnecessary files to reduce image size
RUN dnf clean all && rm -rf /var/cache/dnf

# Set default command to bash
CMD ["/bin/bash"]
