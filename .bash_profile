export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

[ -f .dotfiles/config.bash ] && source .dotfiles/config.bash
[ -f .cargo/bin/nu ] && exec .cargo/bin/nu

if [[ -z $DISPLAY && $TTY = /dev/tty1 &&  ]]; then
  if command -v sway >/dev/null 2>&1
  then
      exec sway
  fi

  if command -v startx >/dev/null 2>&1
  then
      exec startx
  fi
fi
