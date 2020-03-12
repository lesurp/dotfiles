autoload -U compinit && compinit

export ZSH="${HOME}/.zsh"
ZSH_CACHE_DIR="$ZSH/cache"
ZSH_CUSTOM="$ZSH/custom"
SHORT_HOST=${HOST/.*/}
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ($ZSH/lib/*.zsh); do
  custom_config_file="${ZSH_CUSTOM}/lib/${config_file:t}"
  [ -f "${custom_config_file}" ] && config_file=${custom_config_file}
  source $config_file
done

if [[ $ZSH_DISABLE_COMPFIX != true ]]; then
  # If completion insecurities exist, warn the user
  handle_completion_insecurities
  # Load only from secure directories
  compinit -i -C -d "${ZSH_COMPDUMP}"
else
  # If the user wants it, load from all found directories
  compinit -u -C -d "${ZSH_COMPDUMP}"
fi

# Load the theme
source $ZSH/theme

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

### QoL / theming
alias v=nvim
alias g=git
alias icat="kitty +kitten icat" # display image in terminal
alias d="nvim -d" # diff files
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' # handle dotfiles
alias cmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
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
