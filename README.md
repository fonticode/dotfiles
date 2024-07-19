# dotfiles

### Dependencies
```sh
sudo apt install npm python3-venv python3-pip -y
```

### Nerd Fonts
```sh
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip
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

### Qtile
```sh
pip install xcffib
pip install qtile
echo 'PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
sudo touch /usr/share/xsessions/qtile.desktop
sudo su
echo '[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling'  > /usr/share/xsessions/qtile.desktop
# su <user> or exit terminal
```

### Symlinks with stow
```sh
stow alacritty
stow tmux
stow nvim
stow qtile
```
