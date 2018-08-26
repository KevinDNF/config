#
# ~/.bashrc
#

function initTmux() {
    if [ -n "$(tmux list-sessions 2> /dev/null)" ]; then
    	tmux attach
    elif [ -n "$SSH_CONNECTION" ]; then
    	tmux
    fi
}

if [ "$TERM" = "linux" ]; then
    _sedcmd='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fa-f]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_sedcmd" $home/.xresources | awk '$1 < 16 {printf "\\e]p%x%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
	initTmux
elif [ "$TERM" = "screen" ]; then
	export TERM="screen-256color"
else
	initTmux
fi

export BROWSER=/usr/bin/vivaldi-stable
export EDITOR=/usr/bin/vim
export MONKEY="$HOME/Programs/monkey2"
export VISUAL=/usr/bin/vim
RUBYPATH="$HOME/.gem/ruby"
SCRIPTS=".config/scripts"
PATH="$SCRIPTS:$MONKEY:$MONKEY/bin:$PATH:$RUBYPATH"
export PATH

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -F --group-directories-first '
alias la='ls -a'
alias ll='ls -l'
alias grep="grep --color=always"
alias egrep="egrep --color=always"
alias gport='google-chrome-stable --proxy-server=wwwcache.port.ac.uk:81'
if [ -n "$(whereis highlight | sed 's/highlight://')" ]; then
    #Highlight installed
    alias cat="highlight --out-format=xterm256"
fi

if [ ! -n "$( whereis pip | grep pip3 )" ] && \
		[ ! -n "$(alias pip 2> /dev/null | grep pip3)" ] ;then
	alias pip='pip3'
	#echo "Pip alias set to pip3"
fi

# Appends instead of overwritting the History file
shopt -s histappend 

#updates text fill after commands
shopt -s checkwinsize

#cd not required
shopt -s autocd

echo -e -n "\x1b[\x34 q" # changes to steady underline

fcd() {

	cd "$(find ~/ -iname "$1" | head -1 )"

}

fcf() {

	cd "$(dirname "$(find ~/ -iname "$1" | head -1)")"
}

# get shorten path
function shorten_path() {
    pwd | sed "s/$(echo "$HOME" | sed 's/\//\\\//g')//g"
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "<${BRANCH}${STAT}>"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

export PS1="\[\e[31m\]\`nonzero_return\`\[\e[m[\]\u@\h \[\e[m\]\W]\[\e[m\]\`parse_git_branch\`\[\e[m\]\\$\[\e[m\] "


if [ -n "$SSH_CONNECTION" ]; then
    ERRCODE="\[\e[31m\]\`nonzero_return\`\[\e[m[\]"
    USERHOST="\[\e[36m\]\u@\h \[\e[m\]"
    USRPATH="\[\e[34m\]\W\[\e[m]"
    #SHORTUSRPATH="\[\e[34m\]\`shorten_path\`\[\e[m"
    GITBRANCH="\[\e[m\]\`parse_git_branch\`\[\e[m\]\\$\[\e[m\] "

    export PS1=$ERRCODE$USERHOST$USRPATH$GITBRANCH$SHORTUSRPATH

else
    # Sets keyboard to gb
    setxkbmap gb
    setxkbmap -option caps:swapescape

    if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
         exec startx -- -background none
    fi
fi
