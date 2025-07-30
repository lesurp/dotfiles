use std/config light-theme

$env.config = {
    color_config: (light-theme)
    show_banner: false # true or false to enable or disable the welcome banner at startup
    keybindings: [
        {
            name: take_history_hint
            modifier: shift
            keycode: enter
            mode: [emacs, vi_normal, vi_insert]
            event: { 
                until: [
                    { send: historyhintcomplete }
                    { send: enter }
                ]
            }
        }
        {
            name: fuzzy_file
            modifier: control
            keycode: char_t
            mode: [emacs, vi_normal, vi_insert]
            event: {
                send: executehostcommand
                cmd: "commandline edit --insert (fzf --color=light)"
        }
        }
    ]
}

open .dotfiles/config
  | split row "\n"
  | str substring ("export " | str length)..
  | split column "="
  | reduce -f {} {|it, acc| $acc | upsert $it.column1 $it.column2 }
  | load-env

def --wrapped dotconf [...args: string] {
    /usr/bin/git --git-dir=($env.DOTFILES_REPO) --work-tree=($env.HOME) ...$args
}
alias g = git
alias h = hx

const compl = "~/.dotfiles/install/nu_scripts/custom-completions/"
source (if ($compl | path exists) { $"($compl)/git/git-completions.nu" } else { null })
source (if ($compl | path exists) { $"($compl)/cargo/cargo-completions.nu" } else { null })
source (if ($compl | path exists) { $"($compl)/rg/rg-completions.nu" } else { null })
source (if ($compl | path exists) { $"($compl)/zoxide/zoxide-completions.nu" } else { null })

const panache_git_path = "~/.dotfiles/install/nu_scripts/modules/prompt/panache-git.nu"
use (if ($panache_git_path | path exists) { $panache_git_path} else { null }) main

$env.CMAKE_EXPORT_COMPILE_COMMANDS = 1
$env.CMAKE_GENERATOR = "Ninja"

def git-lazycommit [] {
    for $it in (git ls-files --modified | split row "\n") {
        let last_hash = git log -n 1 --pretty=format:%H $it
        git add $it
        git commit --fixup=$last_hash
    }
}

alias splitr = split row "\n"

def --env mkcd [dir: string] {
    mkdir $dir
    cd $dir
}

module rplace_module {
    def curdir [context: string] {
        ls --short-names | get name
    }

    export def rplace [find: string, replace: string, file_or_dir?: string@curdir] {
        let file_or_dir = match $file_or_dir {
          null => { "./" }
          _ => { $file_or_dir }
        };
    
        let files = match ($file_or_dir | path type) {
            dir => { rg --files-with-matches $find $file_or_dir | splitr }
            file => { [$file_or_dir] }
        }

        $files
            | each {|fname|
                open --raw $fname
                    | str replace --all --regex $find $replace
                    | save $fname -f; $fname
                }
    }
}

def hell [pattern: string] {
    hx ...(rg --files-with-matches $pattern | splitr)
}

def hellf [pattern: string] {
    hx ...(glob --no-dir **/$pattern)
}

use rplace_module rplace;
