#!/bin/bash

clear

# Function to check if nvm is installed
check_nvm_installed() {
    # Check if nvm is available
    command -v nvm &> /dev/null
}

# Function to load nvm
load_nvm() {
    # Load nvm if it is installed
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

# Function to install nvm
install_nvm() {
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

    # Load nvm
    load_nvm
    echo "NVM installed successfully."
}

# Function to install Node.js using nvm
install_node() {
    echo "Installing Node.js using NVM..."
    nvm install node  # Install the latest version of Node.js
    nvm use node      # Use the latest version
}

# Load nvm if it's already installed
load_nvm

# Check if nvm is installed
if check_nvm_installed; then
    echo "NVM is already installed."

    # Check if Node.js is installed using nvm
    if command -v node &> /dev/null; then
        echo "Node.js is already installed."

        # Run npm install and start the server
        echo "Running 'npm install'..."
        npm install

        echo "Starting the server..."
        node server.js
    else
        echo "Node.js is not installed. Installing..."
        install_node

        # Check if installation was successful
        if command -v node &> /dev/null; then
            echo "Node.js has been installed successfully."
            echo "Running 'npm install'..."
            npm install

            echo "Starting the server..."
            node server.js
        else
            echo "Failed to install Node.js. Please install it manually."
            exit 1
        fi
    fi
else
    echo "NVM is not installed. Installing..."
    install_nvm
    install_node

    # Check if installation was successful
    if command -v node &> /dev/null; then
        echo "Node.js has been installed successfully."
        echo "Running 'npm install'..."
        npm install

        echo "Starting the server..."
        node server.js
    else
        echo "Failed to install Node.js. Please install it manually."
        exit 1
    fi
fi
