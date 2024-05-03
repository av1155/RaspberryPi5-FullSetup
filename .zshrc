# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Pure prompt path
fpath+=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/pure

# Initialize Pure prompt
autoload -U promptinit; promptinit
prompt pure


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# <-------------------- CUSTOM FUNCTIONS -------------------->


# Sourced + Aliased Scripts ------------------------------------------------------->
[ -f ~/scripts/scripts/JavaProject.zsh ] && { source ~/scripts/scripts/JavaProject.zsh; alias jp="javaproject"; }
[ -f ~/scripts/scripts/JavaProjectManager/JavaProjectManager.zsh ] && alias jcr="~/scripts/scripts/JavaProjectManager/JavaProjectManager.zsh"
[ -f ~/scripts/scripts/imgp.sh ] && alias imgp="~/scripts/scripts/imgp.sh"
[ -f ~/scripts/scripts/sqlurl.sh ] && alias sqlurl="~/scripts/scripts/sqlurl.sh"
[ -f ~/scripts/scripts/nvim_surround_usage.sh ] && alias vs="~/scripts/scripts/nvim_surround_usage.sh"

alias vim='/home/andreaventi/neovim-aarch64-appimage/nvim-v0.9.4.appimage'
# alias fd='fdfind'

# Check if Git is installed
if command -v git &>/dev/null; then

    # Staging and Committing
    alias ga="git add"                                           # Stage all changes
    alias gap="git add -p"                                       # Stage changes interactively
    alias gcm="git commit -m"                                    # Commit with a message
    alias gra="git commit --amend --reset-author --no-edit"      # Amend the last commit without changing its message
    alias unwip="git reset HEAD~"                                # Undo the last commit but keep changes
    alias uncommit="git reset HEAD~ --hard"                      # Undo the last commit and discard changes

    # Branch and Merge
    alias gco="git checkout"                                     # Switch branches or restore working tree files
    alias gpfwl="git push --force-with-lease"                    # Force push with lease for safety
    alias gprune="git branch --merged main | grep -v '^[ *]*main\$' | xargs git branch -d" # Delete branches merged into main

    # Repository Status and Inspection
    alias gs="git status"                                        # Show the working tree status
    alias gl="git lg"                                            # Show commit logs in a graph format
    alias glo="git log --oneline"                                # Show commit logs in a single line each
    alias glt="git describe --tags --abbrev=0"                   # Describe the latest tag

    # Remote Operations
    alias gpr="git pull -r"                                      # Pull with rebase
    alias gup="gco main && gpr && gco -"                         # Update the current branch with changes from main

    # Stashing
    alias hangon="git stash save -u"                             # Stash changes including untracked files
    alias gsp="git stash pop"                                    # Apply stashed changes and remove them from the stash

    # Cleanup
    alias gclean="git clean -df"                                 # Remove untracked files and directories
    alias cleanstate="unwip && git checkout . && git clean -df"  # Undo last commit, revert changes, and clean untracked files

    # Other Aliases
    alias pear="git pair "                                       # Set up git pair for pair programming (requires git-pair gem)
    alias rspec_units="rspec --exclude-pattern \"**/features/*_spec.rb\"" # Run RSpec tests excluding feature specs
    alias awsume=". awsume sso;. awsume"                         # Alias for AWS role assumption

fi

# Check if Tmux is installed
if command -v tmux &>/dev/null; then

    # Tmux Aliases
    alias ta="tmux attach -t"                                    # Attaches tmux to a session (example: ta portal)
    alias tn="tmux new-session -s "                              # Creates a new session
    alias tk="tmux kill-session -t "                             # Kill session
    alias tl="tmux list-sessions"                                # Lists all ongoing sessions
    alias td="tmux detach"                                       # Detach from session
    alias tc="clear; tmux clear-history; clear"                  # Tmux Clear pane

fi

# Check if colorls is installed
if command -v colorls &>/dev/null; then

    alias ls="colorls -A --gs --sd"                              # Lists most files, directories first, with git status.
    alias la="colorls -oA --sd --gs"                             # Full listing of all files, directories first, with git status.
    alias lf="colorls -foa --sd --gs"                            # File-only listing, directories first, with git status.
    alias lt="colorls --tree=3 --sd --gs --hyperlink"            # Tree view of directories with git status and hyperlinks.

fi

# <-------------------- FZF INITIALIZATION -------------------->
# Source fzf if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"            # Foreground color
bg="#011628"            # Background color [UNUSED]
bg_highlight="#143652"  # Background highlight color [UNUSED]
purple="#B388FF"        # Purple color for highlights
blue="#06BCE4"          # Blue color for info
cyan="#2CF9ED"          # Cyan color for various elements


# Set default FZF options
export FZF_DEFAULT_OPTS="-m --height 70% --border --extended --layout=reverse --color=fg:${fg},hl:${purple},fg+:${fg},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# https://github.com/junegunn/fzf-git.sh
source ~/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"


# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ----- Bat (better cat) -----
export BAT_THEME="Catppuccin Macchiato"

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias z='zoxide query'
export FUNCNEST=100
alias z="cd"
# alias cd="z_cd"

# function z_cd() {
#     if [[ -z "$1" ]]; then
#         builtin cd  # Use the built-in cd command directly
#     else
#         local dir=$(zoxide query "$@")  # Capture the output of zoxide query
#         if [[ -n "$dir" ]]; then
#             builtin cd "$dir"
#         else
#             builtin cd "$@"  # Fallback to regular cd if zoxide doesn't return a directory
#         fi
#     fi
# }

# ---- Lazygit ----

alias lg="lazygit"


# fcd: A function to interactively navigate directories using find, fzf, and colorls.
# This script allows you to visually search and select directories within a specified depth
# and then directly change to the selected directory. It uses 'find' to list directories,
# 'fzf' for interactive selection, and 'colorls' to preview directories with color coding.

if command -v fd &>/dev/null && command -v fzf &>/dev/null && command -v colorls &>/dev/null; then
    fcd() {
        local depth="${1:-9}"  # Default depth is 9, but can be overridden by first argument
        local dir
        dir=$(fd --type d --hidden --max-depth "$depth"\
            --exclude '.git' \
            --exclude 'Photos' \
            --exclude '.local' \
            --exclude 'node_modules' \
            --exclude 'venv' \
            --exclude 'env' \
            --exclude '.venv' \
            --exclude 'build' \
            --exclude 'dist' \
            --exclude 'cache' \
            --exclude '.cache' \
            --exclude 'tmp' \
            --exclude '.tmp' \
            --exclude 'temp' \
            --exclude '.temp' \
            --exclude 'Trash' \
            --exclude '.Trash' \
            . 2>/dev/null | fzf --preview 'eza --tree --level 2 --color=always {}' +m) && cd "$dir" || return
    }
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andreaventi/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andreaventi/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/andreaventi/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/andreaventi/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/andreaventi/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/andreaventi/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# <------------------ NVIM PYTHON PATH CONFIGURATION ------------------>

# Check if Conda is installed
if command -v conda >/dev/null 2>&1; then
    # Conda-specific configuration

    # Function to set NVIM_PYTHON_PATH
    set_python_path_for_neovim() {
        if [[ -n "$CONDA_PREFIX" ]]; then
            export NVIM_PYTHON_PATH="$CONDA_PREFIX/bin/python"
        else
            # Fallback to system Python (Python 3) if Conda is not active
            local system_python_path=$(which python3)
            if [[ -z "$system_python_path" ]]; then
                echo "Python is not installed. Please install Python to use with Neovim."
            else
                export NVIM_PYTHON_PATH="$system_python_path"
            fi
        fi
    }

    # Initialize NVIM_PYTHON_PATH
    set_python_path_for_neovim

    # Hook into the precmd function
    function precmd_set_python_path() {
        if [[ "$PREV_CONDA_PREFIX" != "$CONDA_PREFIX" ]]; then
            set_python_path_for_neovim
            PREV_CONDA_PREFIX="$CONDA_PREFIX"
        fi
    }

    # Save the initial Conda prefix
    PREV_CONDA_PREFIX="$CONDA_PREFIX"

    # Add the hook to precmd
    autoload -U add-zsh-hook
    add-zsh-hook precmd precmd_set_python_path

else
    # Non-Conda environment: Check if Python is installed
    python_path=$(which python3)
    if [[ -z "$python_path" ]]; then
        echo "Python is not installed. Please install Python to use with Neovim."
    else
        export NVIM_PYTHON_PATH="$python_path"
    fi
fi

# Add the following line in `~/.config/nvim/lua/user/options.lua` to set the dynamic Python executable for pynvim
# python3_host_prog = "$NVIM_PYTHON_PATH",


export PATH=$PATH:/sbin:/usr/sbin

export JAVA_HOME=/usr/local/jdk-21.0.2
export PATH=$PATH:$JAVA_HOME/bin

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# <-------------------- JAVA CLASSPATH CONFIGURATION -------------------->

# Define the base directory where the jars are stored
CLASSPATH_PREFIX="/home/andreaventi/.dotfiles/configs/javaClasspath"

# Clear existing java classpath entries
export CLASSPATH=""

# Add each jar file found in the directory and its subdirectories to the CLASSPATH
for jar in $(find "$CLASSPATH_PREFIX" -name '*.jar'); do
  export CLASSPATH="$CLASSPATH:$jar"
done

