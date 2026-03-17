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
    fast-syntax-highlighting
)

export PYTHON_AUTO_VRUN=true

source $ZSH/oh-my-zsh.sh

#
# zsh configuration
#

export FZF_DEFAULT_OPTS='
  --tmux=80%
  --multi
  --gutter=" "
  --pointer=">"
  --layout=default
  --marker="+ "
  --tabstop=4
  --no-scrollbar
  --border=none
  --input-border=rounded
  --list-border=rounded
  --info=inline-right
  --preview-window=right:50%:border-rounded
  --color=fg:white,fg+:bright-white,bg+:black,hl:green,hl+:bright-green
  --color=border:white,prompt:blue,pointer:green,marker:yellow,info:white
'
export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always {}'
  --preview-window=right:50%:border-rounded
"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window=right:50%:border-rounded:wrap
"

export FZF_ALT_C_OPTS="
  --preview 'ls --color=always {}'
  --preview-window=right:50%:border-rounded
"

export GOPATH="$HOME"/.local/share/go
export PATH="$PATH:$(go env GOPATH)/bin"

source ~/.local/share/omarchy/default/bash/aliases

eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
