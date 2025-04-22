export ZSH="$HOME/.oh-my-zsh"

DEFAULT_USER=$USER
prompt_context(){}
ZSH_THEME="eastwood"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  zsh-syntax-highlighting
  git
  brew
  node
  npm
  tmux
  httpie
  docker
  fzf
  z
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi
export EDITOR='nvim'

alias please='sudo'
alias zrc='nvim ~/.zshrc'
alias zsc='source ~/.zshrc'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# VI BINDINGS
bindkey -v

#NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#PYENV
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
