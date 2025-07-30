export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

[ -f .dotfiles/config.bash ] && source .dotfiles/config.bash
[ -f .cargo/bin/nu ] && exec .cargo/bin/nu
