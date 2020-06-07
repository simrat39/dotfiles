#!/bin/bash

ARCH_PACKAGES="bspwm rofi kitty feh picom nvim ranger base-devel"
DOTCONFIG="bspwm sxhkd rofi kitty nvim walls spicetify cxxbar"
DOTHOME="fonts zshrc xinitrc bin themes"
AUR_PACKAGES="python-ueberzug-git bear"

# Install Arch packages
sudo pacman -Syu "$ARCH_PACKAGES"

# Install AUR stuff
for pack in $AUR_PACKAGES
do
  git clone https://aur.archlinux.org/"$pack" buildhere
  cd buildhere && makepkg -si
  cd .. && rm -rf buildhere
  cd ..
done

# Install lemonbar
git clone https://github.com/simrat39/bar.git
cd bar
make
sudo make install
cd .. && rm -rf bar

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
