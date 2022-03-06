export ZSH="$HOME/.oh-my-zsh"

# ZSH
DEFAULT_USER=$USER
prompt_context(){}
ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  brew
  node
  yarn
  docker
  fzf
  z
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# Git alias for config files repository management
alias gconfig="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#PYENV
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

#LIBRARIES
# export LDFLAGS="-L/usr/local/opt/zlib/lib"
# export CPPFLAGS="-I/usr/local/opt/zlib/include"

# export LDFLAGS="-L/usr/local/opt/bzip2/lib"
# export CPPFLAGS="-I/usr/local/opt/bzip2/include"

# export LDFLAGS="-L/usr/local/opt/libiconv/lib"
# export CPPFLAGS="-I/usr/local/opt/libiconv/include"
