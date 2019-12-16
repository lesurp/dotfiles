##### zsh conf
# colorized man
function man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		PAGER="${commands[less]:-$PAGER}" \
		_NROFF_U=1 \
		PATH="$HOME/bin:$PATH" \
			man "$@"
}

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="meine_theme"
plugins=(zsh-autosuggestions)
# binds the auto complete to alt+enter
bindkey '^[' autosuggest-execute
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'
# add custom completion scripts
source $ZSH/oh-my-zsh.sh
fpath=($HOME/.zsh/completions $fpath)
autoload -U compinit && compinit

### QoL / theming
alias v=nvim
alias g=git
alias icat="kitty +kitten icat" # display image in terminal
alias d="nvim -d" # diff files
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' # handle dotfiles
if [ "$TERM" = "xterm-kitty" ]
then;
    alias ssh="kitty +kitten ssh"
fi
export EDITOR='nvr -s --remote-wait-silent'
export GIT_EDITOR='nvr -s --remote-wait-silent'
export FZF_DEFAULT_COMMAND='rg --files --glob "!third_party/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--color=light"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export rcp="rsync -avhW --no-compress --progress"

# funny stuff
export CXX=clang++
export CC=clang
