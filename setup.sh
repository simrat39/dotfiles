#!/bin/bash
ARCH_PACKAGES="bspwm rofi kitty feh picom neovim ranger base-devel fzf ripgrep"
DOTCONFIG="bspwm sxhkd rofi kitty nvim walls spicetify cxxbar zsh mimeapps.list ranger"
DOTHOME="fonts xinitrc bin themes zshenv"
AUR_PACKAGES="python-ueberzug-git bear"

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

# Install lemonbar
cd ~
git clone https://github.com/simrat39/bar.git
cd bar
make
sudo make install
cd .. && rm -rf bar

git clone htpps://github.com/simrat39/cxxbar.git
cd cxxbar
make
cd ../dotfiles

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
