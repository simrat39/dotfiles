import subprocess

def run(command):
    return subprocess.call(command,shell=True)

arch_packages = "i3-gaps rofi termite feh python-dbus python-pip wget"
arch_deps = "base-devel"
aur_packages = ['compton-tryone-git','polybar']
python_packages = "bs4 requests html5lib"
config_locat = ['i3','rofi','termite','polybar','compton','bootleggerritpush.sh','appimagelauncher.cfg','walls']

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
    run('rm -rf ~/.xprofile')

def makeDir():
    print("Making sure directories exist")
    run('mkdir ~/.themes && mkdir ~/.local/share/color-schemes && mkdir ~/.local/share/plasma/desktoptheme')

def install_and_symlink():
    makeDir()
    print("Symlinking config files")
    for package in config_locat:
        run('ln -s ~/dotfiles/.config/{} ~/.config/'.format(package,package))
    print('Symlinking fonts')
    run('ln -s ~/dotfiles/.fonts ~/.fonts')
    run('ln -s ~/dotfiles/.xprofile ~/.xprofile')

    print("Installing themes")
    run('cp -r ~/dotfiles/.themes/* ~/.themes/')
    run('cp -r ~/dotfiles/.local/share/* ~/.local/share/')

    installZSH()
    print("Symlinking .zshrc")
    run('ln -s ~/dotfiles/.zshrc ~/.zshrc')


installArchPackages()
installAURdeps()
installAURPackages()
installPythonPackages()
cleanup()
install_and_symlink()

print("Finished! Dont forget to enable your theme and log out")
