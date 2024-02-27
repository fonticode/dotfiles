# dotfiles

### Dependencies
```sh
sudo apt install npm python3-venv python3-pip -y
```

### Nerd Fonts
```sh
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hermit.zip
unzip Hermit.zip -d ~/.fonts/
fc-cache -fv
```

### Tmux Plugin Manager
```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### NVChad
```sh
# uninstall
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
# unstall
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
rm -rf ~/.config/nvim/lua/custom/
```

### Symlinks with stow
```sh
stow alacritty
stow tmux
stow nvim
```