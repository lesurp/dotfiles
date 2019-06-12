##### zsh conf
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="pygmalion"
plugins=(git colored-man-pages zsh-autosuggestions)
# binds the auto complete to alt+enter
bindkey '^[' autosuggest-execute
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'
# add custom completion scripts
fpath=(~/.zsh/completion $fpath) 
source $ZSH/oh-my-zsh.sh

### QoL / theming
alias v=nvim
alias icat="kitty +kitten icat" # display image in terminal
alias d="nvim -d" # diff files
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' # handle dotfiles
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='rg --files --glob "!3rdparty/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--color=light"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export rcp="rsync -avhW --no-compress --progress"

# funny stuff
export CXX=clang++
export CC=clang
