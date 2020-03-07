import subprocess

def run(command):
    return subprocess.call(command,shell=True)

arch_packages = "i3-gaps rofi termite feh python-dbus python-pip wget picom"
arch_deps = "base-devel"
aur_packages = ['polybar']
python_packages = "bs4 requests html5lib"
config_locat = ['i3','rofi','termite','polybar','picom','bootleggerritpush.sh','appimagelauncher.cfg','walls','dunst']

def installArchPackages():
    print("Installing packages from arch repositories")
    run('sudo pacman -S {}'.format(arch_packages))

def installAURdeps():
    print("Installing AUR dependencies")
    run('sudo pacman -S {}'.format(arch_deps))

def installAURPackages():
    print("Installing packages from the AUR")
    for package in aur_packages:
        run('git clone https://aur.archlinux.org/{} buildhere'.format(package))
        run('cd buildhere && makepkg -si')
        run('cd ~/dotfiles/ && rm -rf buildhere')

def installPythonPackages():
    print("Installing required python packages")
    run('sudo pip install {}'.format(python_packages))

def installZSH():
    print("Installing oh-my-zsh")
    run('sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"')

def cleanup():
    print("Removing existing configs")
    for package in config_locat:
        run('rm -rf ~/.config/{}'.format(package))
    run('rm -rf ~/.fonts')
    run('rm -rf ~/.zshrc')
    run('rm -rf ~/.xinitrc')
    run('rm -rf ~/.bin')
    run('rm -rf ~/.themes')

def install_and_symlink():
    print("Symlinking config files")
    for package in config_locat:
        run('ln -s ~/dotfiles/.config/{} ~/.config/'.format(package))
    print('Symlinking fonts')
    run('ln -s ~/dotfiles/.fonts ~/.fonts')

    run('ln -s ~/dotfiles/.xinitrc ~/.xinitrc')
    run('ln -s ~/dotfiles/.bin ~/.bin')

    print("Installing themes")
    run('ln -s ~/dotfiles/.themes/ ~/.themes')
    run('ln -s ~/dotfiles/.config/gtk-3.0/gtk.css ~/.config/gtk-3.0/gtk.css')

    installZSH()
    print("Symlinking .zshrc")
    run('ln -s ~/dotfiles/.zshrc ~/.zshrc')

#installArchPackages()
#installAURdeps()
#installAURPackages()
#installPythonPackages()
cleanup()
install_and_symlink()

print("Finished! Dont forget to enable your theme and log out")

# usermod -G video simrat39
