#
# ~/.bashrc
#

shopt -s autocd

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export MONKEY="$HOME/Programs/monkey2"
PATH="$MONKEY:$MONKEY/bin:$PATH"
PATH="/root/.gem/ruby/2.5.0/bin:$PATH"
export PATH


echo -e -n "\x1b[\x34 q" # changes to steady underline

alias ls='ls --color=auto -F --group-directories-first '
alias la='ls -a'
alias wifi='. .config/scripts/wifi.sh'
alias gport='google-chrome-stable --proxy-server=wwwcache.port.ac.uk:81'
alias grep="grep --color=always"
#alias cat="highlight --out-format=xterm256"


fcd() {

	cd "$(find ~/ -iname "$1" | head -1 )"

}

fcf() {

	cd "$(dirname "$(find ~/ -iname "$1" | head -1)")"
}


#PS1='[\u@\h \w]\$ '
###----------------

##########################

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



######################

# Appends instead of overwritting the History file
shopt -s histappend

# Sets keyboard to gb
setxkbmap gb
setxkbmap -option caps:swapescape


#updates text fill after commands
shopt -s checkwinsize

###------------------
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	 exec startx -- -background none
fi


export BROWSER=/usr/bin/vivaldi-stable
export EDITOR=/usr/bin/vim
