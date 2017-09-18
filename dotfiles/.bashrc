#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/bin" ] ; then
	export PATH="$HOME/bin:$PATH"
fi

alias ls='ls --color=auto'
alias la='ls --color=auto -la'
alias r='ranger'
PS1='\u@\h \W\$ '

