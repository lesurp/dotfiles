autoload -U compinit compaudit

export ZSH="${HOME}/.zsh"
ZSH_CACHE_DIR="$ZSH/cache"
SHORT_HOST=${HOST/.*/}
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

for config_file ($ZSH/lib/*.zsh); do
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

### QoL / theming
alias v=nvim
alias g=git
alias icat="kitty +kitten icat" # display image in terminal
alias d="nvim -d" # diff files
alias config='/usr/bin/git --git-dir=${DOTFILES_REPO} --work-tree=$HOME' # handle dotfiles
if [ "$TERM" = "xterm-kitty" ]
then;
    alias ssh="kitty +kitten ssh"
fi
export EDITOR='nvr -s --remote-wait-silent'
export GIT_EDITOR='nvr -s --remote-wait-silent'
export FZF_DEFAULT_COMMAND='rg --files --glob "!third_party/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--color=light"
export CMAKE_EXPORT_COMPILE_COMMANDS=1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias rcp="rsync -avhW --no-compress --progress"

export DTSETS=$HOME/Datasets
export CMAKE_PREFIX_PATH="/opt/opencv_3/opencv-3.4.7/build"
export PYTHONPATH=/opt/opencv_3/install/lib/python3.7/site-packages

function b {
    cd build
    local cd_exit_code=$?
    make -j16 || ninja
    local build_exit_code=$?
    if [ $cd_exit_code -eq 0 ]; then
        cd -
    fi
    return $build_exit_code
}

function vssh() {
    nvim scp://$1/$2
}

function nvrssh() {
    nvr scp://$1/$2
}

export LD_LIBRARY_PATH="/usr/local/cuda/lib64"
# python3.7 (built from source)
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
# opencv...
export LD_LIBRARY_PATH="/opt/opencv_3/install/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/TensorRT-7.0.0.11/lib"
export PATH="/usr/local/cuda/bin:$PATH"
export TensorRT_DIR=/opt/TensorRT-7.0.0.11
function cmake_vcpkg {
    cmake -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake "$@"
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lesur/miniconda2/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lesur/miniconda2/etc/profile.d/conda.sh" ]; then
        . "/home/lesur/miniconda2/etc/profile.d/conda.sh"
    else
        export PATH="/home/lesur/miniconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
