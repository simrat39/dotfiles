# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:/usr/local/bin:$HOME/.pub-cache/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/simrat39/.config/zsh/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZDOTDIR/.p10k.zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

alias reposync="repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j$(nproc --all)"
alias goodbyeorphans="sudo pacman -Rs $(pacman -Qqtd)"

export EDITOR="nvim";
export TERMINAL="kitty"
export BROWSER="firefox"

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
