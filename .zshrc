export ZSH="$HOME/.oh-my-zsh"

# ZSH
DEFAULT_USER=$USER
prompt_context(){}
ZSH_THEME="eastwood"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  brew
  node
  httpie
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

# VERY IMPORTANT
alias please="sudo"
eval $(thefuck --alias)

# NEOVIM
export PATH="/usr/local/nvim/bin:$PATH"

#NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#PYENV
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

#BREW
export HOMEBREW_NO_AUTO_UPDATE=1
