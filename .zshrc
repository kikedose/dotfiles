export ZSH="$HOME/.oh-my-zsh"

DEFAULT_USER=$USER
prompt_context(){}
ZSH_THEME="eastwood"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  zsh-syntax-highlighting
  # git
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

# ALIASES
alias please='sudo'
alias zrc='nvim ~/.zshrc'
alias zsc='source ~/.zshrc'
# alias bat='batcat'
# alias fd='fdfind'

# FUCK
eval $(thefuck --alias)

# DOTFILES
dotfiles() {
  /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}
# compdef dotfiles=git

# VOLUME
vol() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        if [ "$1" -ge 0 ] && [ "$1" -le 100 ]; then
            local vol_decimal=$(printf "%.2f" $(( $1 / 100.0 )))
            wpctl set-volume @DEFAULT_SINK@ "$vol_decimal"
            echo "Volume set to $1%"
        else
            echo "Error: Please enter a number between 0 and 100."
        fi
    else
        echo "Usage: vol <0-100>"
    fi
}

# dadd() {
#   local file
#   file=$(dotfiles status --porcelain | fzf --preview "bat --style=numbers --color=always --line-range=:500 $HOME/{1}" | awk '{print $2}')
#   [[ -n $file ]] && dotfiles add "$file"
# }

# FD + FZF
# git-ignores `**` autocompletion suggestions
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
_fzf_compgen_path() {
  fd --type=d --hidden --exclude .git . "$1"
}

#NVM
export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh

# WSL + ARCH CLIPBOARD
export PATH="$HOME/.local/bin:$PATH"
