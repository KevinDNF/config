#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
###----------------

# Appends instead of overwritting the History file
shopt -s histappend

# Sets keyboard to gb
setxkbmap gb
setxkbmap -option caps:swapescape


#updates text fill after commands
shopt -s checkwinsize

###------------------
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi

