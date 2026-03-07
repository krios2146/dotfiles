#
# oh-my-zsh configuration
#

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="krios2146"

plugins=(
    git
    virtualenv
    docker
    python
    archlinux
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
)

export PYTHON_AUTO_VRUN=true

source $ZSH/oh-my-zsh.sh

#
# zsh configuration
#

source ~/.local/share/omarchy/default/bash/aliases
