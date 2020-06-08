# This disables running compinit from /etc/zsh
# Reduces startup time by a lot!
skip_global_compinit=1

# My stuff
. $HOME/.dotfiles/config

PATH="${DOTFILES_BINARY_DIR}:$PATH"
PATH="${DOTFILES_BINARY_DIR}/git-aliases:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
