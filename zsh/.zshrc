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

export GOPATH="$HOME"/.local/share/go
export PATH="$PATH:$(go env GOPATH)/bin"

source ~/.local/share/omarchy/default/bash/aliases

eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
