for config_file ($ZSH/lib/*.zsh); do
  source $config_file
done

############ Completion
autoload -U compinit compaudit
fpath+=${DOTFILES_ZSH_COMPLETIONS}
# If completion insecurities exist, warn the user
handle_completion_insecurities
# Load only from secure directories
compinit -i -C -d "${ZSH_COMPDUMP}"

# Load the theme
source ${DOTFILES_ZSH_HOME}/theme
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########### Aliases
alias v=nvim
alias g=git
alias icat="kitty +kitten icat" # display image in terminal
alias d="nvim -d" # diff files
alias config='/usr/bin/git --git-dir=${DOTFILES_REPO} --work-tree=$HOME' # handle dotfiles
alias cmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias rcp="rsync -avhW --no-compress --progress"
if [ "$TERM" = "xterm-kitty" ]
then;
    alias ssh="kitty +kitten ssh"
fi
export CMAKE_EXPORT_COMPILE_COMMANDS=1
