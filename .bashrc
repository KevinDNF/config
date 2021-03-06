# ________________ ~/.bashrc___________________
#|                                             |
#|                  KevinDNF                   |
#|        github.com/kevindnf/config           |
#|                                             |
#|_____________________________________________|

#-----ENV-VAR------#
if [ -n "$TERM_PROGRAM" ]; then
    #On MacOS replaces bsd with gnu utils
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/bin:$MANPATH"
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
    export EDITOR=/usr/local/bin/vim
else
    #Linux Settings
    export BROWSER=/usr/bin/vivaldi-stable
    export EDITOR=/usr/bin/vim
    export VISUAL=/usr/bin/vim
fi
export VISUAL=$EDITOR
RUBYPATH="$HOME/.gem/ruby"
SCRIPTS="$HOME/.config/scripts"
export PATH="$SCRIPTS:$PATH:$RUBYPATH"

#------------------#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#-------ALIAS------#
alias icloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs'
# removes annoying ds_store files
alias cleands='find ~/ -name ".DS_Store" -delete'
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
#------TMUX-------#

function openTmux() {
    if [  -n "$(echo "$TERM" | grep screen)" ]; then
        if [ "$TERM" = "screen" ]; then
            export TERM="screen-256color"
        fi
    else
        if [ -n "$(tmux list-sessions 2> /dev/null)" ]; then
            tmux attach
        else
            tmux
        fi
    fi
}

if [ -n "$SSH_CONNECTION" ] || [ "$TERM" == "linux" ]; then
    openTmux
fi

#------SHELL-SETTINGS-------#

# Appends instead of overwritting the History file
shopt -s histappend 

#updates text fill after commands
shopt -s checkwinsize

#cd not required
shopt -s autocd
shopt -s nocaseglob
shopt -s cdspell

reset-cursor() {
    echo -e -n "\x1b[\x34 q" # changes to steady underline
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

    ERRCODE="\[\e[31m\]\`nonzero_return\`\[\e[m[\]"
    USER="\[\e[36m\]\u \[\e[m\]"
    USERHOST="\[\e[36m\]\u@\h \[\e[m\]"
    USRPATH="\[\e[34m\]\W\[\e[m]"
    GITBRANCH="\[\e[m\]\`parse_git_branch\`\[\e[m\]\\$\[\e[m\] "

if [ -n "$SSH_CONNECTION" ]; then
    export PS1=$ERRCODE$USERHOST$USRPATH$GITBRANCH
else
    export PS1=$(reset-cursor)$ERRCODE$USRPATH$GITBRANCH

    if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
        # Sets keyboard to gb
        setxkbmap gb
        setxkbmap -option caps:swapescape

        exec startx -- -background none
    fi
fi
eval "$(pyenv init -)"
