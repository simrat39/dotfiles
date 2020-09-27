#!/bin/bash
ARCH_PACKAGES="bspwm sxhkd rofi kitty feh picom neovim ranger gnome-flashback gnome fd base-devel dash fzf ripgrep python-pip xclip git"
DOTCONFIG="bspwm sxhkd rofi kitty nvim walls spicetify cxxbar zsh mimeapps.list ranger polybar autostart picom"
DOTHOME="fonts xinitrc bin themes zshenv"
AUR_PACKAGES="python-ueberzug-git bear universal-ctags-git"
PY_PACKAGES="pynvim"

# Install Arch packages
for package in $ARCH_PACKAGES
do
  if ! pacman -Qi "$package" > /dev/null; then
    sudo pacman -S "$package"
  fi
done

# Install AUR stuff
for pack in $AUR_PACKAGES
do
  if ! pacman -Qi "$pack" > /dev/null; then
    git clone https://aur.archlinux.org/"$pack" buildhere
    cd buildhere && makepkg -si
    cd .. && rm -rf buildhere
    cd ..
  fi
done

# Install Python packages
for package in $PY_PACKAGES
do
  pip install "$package"
done

# Cleanup existing things
for diri in $DOTCONFIG
do
  rm -rf ~/.config/"$diri"
done

for diri in $DOTHOME
do
  rm -rf ~/."$diri"
done

# Symlink stuff
for diri in $DOTCONFIG
do
  ln -s ~/dotfiles/.config/"$diri" ~/.config/
done

for diri in $DOTHOME
do
  ln -s ~/dotfiles/."$diri" ~/."$diri"
done

# Misc

# Ranger Icons
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
