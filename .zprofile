# This disables running compinit from /etc/zsh
# Reduces startup time by a lot!
skip_global_compinit=1

# Loads dotfiles configuration
[ -f /home/lesurp/.dotfiles/config ] && source /home/lesurp/.dotfiles/config


############ PATH
# My stuff
. $HOME/.dotfiles/config

PATH="${DOTFILES_BINARY_DIR}:$PATH"
PATH="${DOTFILES_BINARY_DIR}/git-aliases:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH

############ EDITORS and stuff
export EDITOR='nvr -s --remote-wait-silent'
export GIT_EDITOR='nvr -s --remote-wait-silent'
export FZF_DEFAULT_COMMAND='rg --files --glob "!third_party/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--color=light"

########### USED BY OH MY ZSH LIBS
export ZSH="${DOTFILES_ZSH_HOME}"
export ZSH_CACHE_DIR="$ZSH/cache"
export ZSH_COMPDUMP="$ZSH/zcompdump"

########### Finally, call `startx` if we don't run with a dm (e.g. gdm/lightdm)
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
