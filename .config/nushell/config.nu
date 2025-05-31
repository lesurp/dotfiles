# config.nu
#
# Installed by:
# version = "0.104.0"

const nuscripts = "~/.nu_scripts"
const compl = $"($nuscripts)/custom-completions"
source $"($compl)/git/git-completions.nu"
source $"($compl)/cargo/cargo-completions.nu"
source $"($compl)/rg/rg-completions.nu"
source $"($compl)/zoxide/zoxide-completions.nu"
source $"($compl)/zoxide/zoxide-completions.nu"
use $"($nuscripts)/modules/prompt/panache-git.nu" main

open .dotfiles/config
  | split row "\n"
  | str substring ("export " | str length)..
  | split column "="
  | reduce -f {} {|it, acc| $acc | upsert $it.column1 $it.column2 }
  | load-env

use std/config light-theme

$env.PROMPT_COMMAND = {|| panache-git }
$env.PROMPT_INDICATOR = {|| $"(ansi reset)> "}
$env.PROMPT_INDICATOR_VI_INSERT = {|| $"(ansi reset): " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $"(ansi reset)> " }

$env.config = {
  color_config: (light-theme)   # if you want a light theme, replace `$dark_theme` to `$light_theme`
  show_banner: false
  use_kitty_protocol: true
  keybindings: [
    {
      name: fzf
      modifier: control
      keycode: Char_t
      mode: emacs
      event: {
        send: executehostcommand,
        cmd: "commandline edit --insert (fzf)"
      }
    }
    {
      name: autocomplete
      modifier: shift
      keycode: enter
      mode: [ emacs, vi_insert, vi_normal ]
      event: { until: [{send: historyhintcomplete } {send: enter}] }
    }
  ]
}

alias h = hx
alias g = git
alias dotconf = git --git-dir=($env.DOTFILES_REPO) --work-tree=($env.HOME)
