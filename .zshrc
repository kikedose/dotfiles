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
  # tmux
  httpie
  docker
  # fzf
  z
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi
export EDITOR='nvim'

# VI BINDINGS
# bindkey -v
# resolves `vi insert mode` keybind conflicts with fzf
# further debugging necessary
# bindkey -M viins '^I' fzf-completion

# ALIASES
alias please='sudo'
alias zrc='nvim ~/.zshrc'
alias zsc='source ~/.zshrc'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bat='batcat'
alias fd='fdfind'

# FD + FZF
# git-ignores `**` autocompletion suggestions
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
_fzf_compgen_path() {
  fd --type=d --hidden --exclude .git . "$1"
}
# fzf-git commands
source $HOME/.local/share/fzf-git/fzf-git.sh

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# PYENV
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
