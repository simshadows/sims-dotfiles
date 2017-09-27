#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return
# IGNORE FOR NOW.

# Prompt

PS1='\[\e[31m\]\u@\h\[\e[m\] \W\$ '


# Put ~/bin into PATH

if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi


# The usual aliases

alias ls='ls --color=auto'
alias la='ls --color=auto -lah'
alias r='ranger'


# Prevents nesting ranger instances when you repeatedly open shells with Shift+s

function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}


# Very handy pastebins. Pipe in your data, and you get back a URL.
# Multiple are provided for options since some can break.

function pastebin() {
    curl -F '"'"'sprunge=<-'"'"' http://sprunge.us
}

function pastebin2() {
    nc termbin.com 9999
}


# Handy shortcut to quickly clone in something from github

function github() {
    git clone git@github.com:$1.git
}

function githubwiki() {
    git clone git@github.com:$1.wiki.git
}

function githuball() {
    github $1
    githubwiki $1
}


# Other script invocations

# This is where code not intended to be part of the dotfiles repository goes.
# Here, we find machine-specific config, such as aliases to specific files
# on a machine.
[[ -f ~/.bash_custom ]] && source ~/.bash_custom

