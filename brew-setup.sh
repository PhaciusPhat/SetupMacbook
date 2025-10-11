#!/bin/bash

echo "🚀 Starting macOS Brew setup..."

# --- Check if Homebrew is installed ---
if ! command -v brew &> /dev/null; then
  echo "🍺 Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add brew to PATH (for Apple Silicon & Intel)
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed!"
fi

echo "🔄 Updating Homebrew..."
brew update

# --- Brew Packages ---
echo "🍺 Installing Homebrew packages..."

# --- Formulae ---
echo "📦 Installing formulae..."
brew install asdf
brew install btop
brew install docker
brew install docker-completion
brew install gettext
brew install git
brew install libunistring
brew install ollama
brew install pcre2

# --- Casks ---
echo "🧉 Installing casks..."
brew install --cask arc
brew install --cask betterdisplay
brew install --cask chatgpt
brew install --cask clipy
brew install --cask clop
brew install --cask discord
brew install --cask flameshot
brew install --cask insomnia
brew install --cask jetbrains-toolbox
brew install --cask jordanbaird-ice
brew install --cask lens
brew install --cask onlyoffice
brew install --cask orbstack
brew install --cask raycast
brew install --cask rectangle
brew install --cask spotify
brew install --cask visual-studio-code
brew install --cask zalo

echo "🧹 Cleaning up..."
brew cleanup

echo "✅ All installations complete!"
