#
# ~/.bashrc
#
# A lot of this isn't very portable, but it's portable enough for me.
#


# If not running interactively, don't do anything
#[[ $- != *i* ]] && return
# IGNORE FOR NOW.


# System detection
if [[ "$OSTYPE" == "darwin"* ]]; then
    os_type="mac"
    utils_flavour="bsd"
else
    # Catch-all: Assume everything else is GNU.
    os_type="gnu"
    utils_flavour="gnu"
fi


# Prompt
PS1='\[\e[31m\]\u@\h\[\e[m\] \W\$ '


# Put ~/bin into PATH
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi


# The usual aliases
if [[ "$utils_flavour" == "bsd" ]]; then
    alias ls='ls -G'
    alias la='ls -lahG'
else
    alias ls='ls --color=auto'
    alias la='ls --color=auto -lah'
fi
alias cheatsheet='vim -R ~/cheatsheet.md' # Cheatsheet for how to use Linux
alias duu='du --max-depth=1 --all --human-readable --total ' # Summarize file/directory sizes
alias g='git'
alias gg='lazygit' # Interactive CLI git client
alias r='ranger' # CLI file manager
alias rss='newsboat' # My preferred RSS reader client
alias t='tmux new-session -s ' # Create new named tmux session

# Simple one-file Java compilation
# Currently a very system-dependent alias. I should improve this.
alias java17='/usr/lib/jvm/java-17-openjdk/bin/java'

# Simple one-file C++ compilation
# cppbasecompile shouldn't be used directly
alias cppbasecompile='g++ -Werror -Wall -Wextra -Wshadow -std=c++20 -o a.out '
alias cppcompile='cppbasecompile -O2 '
alias cppfast='cppbasecompile -O3 -DNDEBUG -flto -fomit-frame-pointer -march=native '
# For when you're segfaulting
alias cppdebug='cppbasecompile -g -O2 -fsanitize=address '
# Keeps as much information as possible for profiling
alias cppprofile='cppbasecompile -g -O3 -fno-omit-frame-pointer '
# Competitive programming
# (Except I'm not really a properly competitive programmer. Don't use this if you want to avoid debugging "unnecessary" errors.)
alias cppcp='cppbasecompile -O2 -fsanitize=address '


# Automatically reread ~/.Xresources
xrdb -merge ~/.Xresources || true


# Prevents nesting ranger instances when you repeatedly open shells with Shift+s
if [[ "$os_type" == "mac" ]]; then
    function ranger() {
        if [ -z "$RANGER_LEVEL" ]; then
            /usr/local/bin/ranger "$@"
        else
            exit
        fi
    }
else
    function ranger() {
        if [ -z "$RANGER_LEVEL" ]; then
            /usr/bin/ranger "$@"
        else
            exit
        fi
    }
fi


# Different ways to search for things
function search.str() {
    grep -rnw $1 -e $2
}


# Very handy pastebins. Pipe in your data, and you get back a URL.
# Multiple are provided for options since some can break.
function pastebin() {
    curl -F '"'"'sprunge=<-'"'"' http://sprunge.us
}
function pastebin2() {
    nc termbin.com 9999
}


# Clipboard operations
function clip.targets() {
    echo '=== PRIMARY ==='
    xclip -selection primary -t TARGETS -o
    echo '=== CLIPBOARD ==='
    xclip -selection clipboard -t TARGETS -o
}
function clip.get() {
    xclip -selection clipboard -t $1 -o
}

# A very useful "script" for quickly getting a BMP file from CLIPBOARD into a PNG file at
# the CWD. This is very often used when pasting selections from Microsoft Paint in a
# Windows virtual machine.
function clip.bmptofile() {
    if [ -z "$1" ]; then
        echo 'Usage: clip.bmptofile filename-without-extension'
        echo '.png is automatically appended to the filename.'
        return
    fi

    CLIP_TARGET='image/bmp'
    FILENAME=$1'.png'

    BUF=`xclip -selection clipboard -t TARGETS -o | grep ${CLIP_TARGET}`
    if [ "${BUF}" != "${CLIP_TARGET}" ]; then
        echo "Target \`${CLIP_TARGET}\` not found. Aborting."
        return
    fi

    xclip -selection clipboard -t "$CLIP_TARGET" -o | mogrify -format png - > $FILENAME
    echo 'BMP from clipboard saved as '$FILENAME
}


# Node.js Stuff
export PATH="$HOME/.npm-global/bin:$PATH"
export N_PREFIX=$HOME/.n
if [ -d "$HOME/.n" ]; then
    export PATH=$N_PREFIX/bin:$PATH
fi


# Other script invocations

# This is where code not intended to be part of the dotfiles repository goes.
# Here, we find machine-specific config, such as aliases to specific files
# on a machine.
[[ -f ~/.bash_custom ]] && source ~/.bash_custom



# Load Angular CLI autocompletion.
source <(ng completion script)
