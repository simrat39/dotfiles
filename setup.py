import subprocess

def run(command):
    return subprocess.call(command,shell=True)

arch_packages = "i3-gaps rofi termite feh glava python-dbus"
arch_deps = "git base-devel"
aur_packages = ['compton-tryone-git','polybar']
config_locat = ['i3','rofi','termite','glava','polybar','compton','wm.sh','appimagelauncher.cfg','walls']

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

def cleanup():
    print("Removing existing configs")
    for package in config_locat:
        run('rm -rf ~/.config/{}'.format(package))

def makeDir():
    print("Making sure directories exist")
    run('mkdir ~/.themes && mkdir ~/.local/share/color-schemes && mkdir ~/.local/share/plasma/desktoptheme')
    
def install_and_symlink():
    makeDir()
    print("Symlinking config files")
    for package in config_locat:
        run('ln -s ~/dotfiles/.config/{} ~/.config/'.format(package,package))

    print("Installing themes")
    run('cp -r ~/dotfiles/.themes/* ~/.themes/')
    run('cp -r ~/dotfiles/.local/share/* ~/.local/share/')

installArchPackages()
installAURdeps()
installAURPackages()
cleanup()
install_and_symlink()

print("Finished! Dont forget to enable your theme and log out")
