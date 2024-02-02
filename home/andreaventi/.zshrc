# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

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

# Load Pure prompt
fpath+="$HOME/.zsh/pure"
autoload -U promptinit; promptinit

# Set the prompt to Pure
prompt pure

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

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

# fcd: A function to interactively navigate directories using find, fzf, and colorls.
# This script allows you to visually search and select directories within a specified depth
# and then directly change to the selected directory. It uses 'find' to list directories,
# 'fzf' for interactive selection, and 'colorls' to preview directories with color coding.

if command -v find &>/dev/null && command -v fzf &>/dev/null && command -v colorls &>/dev/null; then
    fcd() {
        local depth="${1:-7}"  # Default depth is 7, but can be overridden by first argument
        local dir
        dir=$(find * -type d -maxdepth "$depth" 2>/dev/null | fzf --preview 'colorls --tree=2 --sd --gs --color=always {}' +m) && cd "$dir" || return
    }
fi

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

# Check if colorls is installed
if command -v colorls &>/dev/null; then

    alias ls="colorls -A --gs --sd"                              # Lists most files, directories first, with git status.
    alias la="colorls -oA --sd --gs"                             # Full listing of all files, directories first, with git status.
    alias lf="colorls -foa --sd --gs"                            # File-only listing, directories first, with git status.
    alias lt="colorls --tree=3 --sd --gs --hyperlink"            # Tree view of directories with git status and hyperlinks.

fi

# <-------------------- FZF INITIALIZATION -------------------->

[[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
export FZF_DEFAULT_OPS="--extended --layout=reverse"
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m --height 70% --border --layout=reverse'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/andreaventi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/andreaventi/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/andreaventi/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/andreaventi/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=$PATH:/sbin:/usr/sbin

export JAVA_HOME=/usr/lib/jvm/jdk-21.0.2+13
export PATH=$PATH:$JAVA_HOME/bin
