#!/bin/bash

# ==========================================
#  CONFIGURATION & PACKAGE LISTS
# ==========================================

# 1. Basic Essentials
PKG_BASIC="build-essential software-properties-common \ 
pkg-config pciutils \
curl wget git unzip \
bat"

# 2. Neovim + Tmux (LazyVim Deps)
# Note: 'ripgrep' and 'fd-find' are required for LazyVim
PKG_NVIM="tmux ripgrep fd-find fzf npm luarocks"

# 3. Python Development
PKG_PYTHON="python3 python3-pip python3-venv python3-full"

# 4. C++ Development
PKG_CPP="build-essential cmake gdb clang lldb ninja-build"

# ==========================================
#  SETUP LOGIC
# ==========================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# --- FUNCTION 1: Basic Install ---
install_basic() {
  log_info "Installing Basic Essentials..."
  sudo apt-get update -y
  sudo apt-get install -y $PKG_BASIC
  log_success "Basic tools installed."
}

# --- FUNCTION 2: Neovim & LazyVim ---
install_nvim() {
  log_info "Installing Neovim + Tmux + Dependencies..."

  # Add PPA for Neovim >= 0.9.0
  sudo apt install software-properties-common -y
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt-get update -y
  sudo apt-get install -y neovim $PKG_NVIM

  # Fix fd-find binary name (Ubuntu names it fdfind, plugins want fd)
  if [ ! -f ~/.local/bin/fd ]; then
    mkdir -p ~/.local/bin
    ln -s $(which fdfind) ~/.local/bin/fd
    log_info "Symlinked fdfind -> fd"
  fi

  # Install LazyGit
  if ! command -v lazygit &>/dev/null; then
    log_info "Installing LazyGit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
  fi

  # LazyVim Starter
  if [ ! -d "$HOME/.config/nvim" ]; then
    log_info "Cloning LazyVim starter..."
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
  else
    log_warn "Nvim config already exists. Skipping clone."
  fi

  log_success "Neovim Setup Complete."
}

# --- FUNCTION 3: Symlink Git/SSH ---
configure_symlinks() {
  local HOST_HOME=$DISTROBOX_HOST_HOME

  if [ -z "$HOST_HOME" ]; then
    log_warn "Could not detect DISTROBOX_HOST_HOME variable. Skipping symlinks."
    return
  fi

  log_info "Detected Host Home at: $HOST_HOME"

  # Symlink SSH
  if [ -d "$HOST_HOME/.ssh" ]; then
    [ -d "$HOME/.ssh" ] && [ ! -L "$HOME/.ssh" ] && mv "$HOME/.ssh" "$HOME/.ssh.bak"
    ln -sf "$HOST_HOME/.ssh" "$HOME/.ssh"
    log_success "Linked .ssh from host."
  fi

  # Symlink Gitconfig
  if [ -f "$HOST_HOME/.gitconfig" ]; then
    [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
    ln -sf "$HOST_HOME/.gitconfig" "$HOME/.gitconfig"
    log_success "Linked .gitconfig from host."
  fi
}

# --- FUNCTION 4: Python ---
install_python() {
  log_info "Installing Python Stack..."
  sudo apt-get install -y $PKG_PYTHON

  # Optional: Install uv
  curl -LsSf https://astral.sh/uv/install.sh | sh
  log_success "Python installed (with 'uv')."
}

# --- FUNCTION 5: C++ ---
install_cpp() {
  log_info "Installing C++ Stack..."
  sudo apt-get install -y $PKG_CPP
  log_success "C++ tools installed."
}

# ==========================================
#  MAIN MENU
# ==========================================

echo -e "${YELLOW}Distrobox Setup Assistant${NC}"
echo "-------------------------"
echo "1. Basic Essentials ($PKG_BASIC)"
echo "2. Neovim + Tmux + LazyVim"
echo "3. Configure Git & SSH (Symlink from Host)"
echo "4. Python Development"
echo "5. C++ Development"
echo "0. Install ALL"
echo "-------------------------"
read -p "Enter numbers to install (e.g., '1 4' or '0'): " selections

# Convert "0" to all numbers
if [[ "$selections" == *"0"* ]]; then
  selections="1 2 3 4 5"
fi

echo ""

# Loop over choices
for choice in $selections; do
  case $choice in
  1) install_basic ;;
  2) install_nvim ;;
  3) configure_symlinks ;;
  4) install_python ;;
  5) install_cpp ;;
  *) log_warn "Invalid selection: $choice" ;;
  esac
done

echo -e "\n${GREEN}All selected tasks completed!${NC}" e
