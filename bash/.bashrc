# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## History ##

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable extglob
shopt -s extglob

# Don't completion when the keyword is empty.
shopt -s no_empty_cmd_completion

# stdin or arg to pipe 
_a2pipe() {
    [ -p /dev/stdin ] && cat - || echo $@
}

# lower case, upper case
_lcase() { _a2pipe $@ | tr '[A-Z]' '[a-z]'; }

_ucase() { _a2pipe $@ | tr '[a-z]' '[A-Z]'; }


# isset
_isset() { [ ! -z "${1+x}" ]; }

# expand aliases in shellscript
shopt -s expand_aliases

## Descriminate OS type. ##
alias is_osx="[ $(_lcase $(uname)) == 'darwin' ]"
alias is_linux="[ $(_lcase $(uname)) == 'linux' ]"

if is_osx;
then
    export OS_TYPE='osx'
elif is_linux;
then
    export OS_TYPE='linux'
else
    export OS_TYPE='unknown'
    echo "Unknown OS!"
    exit 1
fi

# prompt
export PS1='\u@\h \w:$ '

export EDITOR='emacsclient -q -nw -c -a ""'

export LANG=ja_JP.UTF-8
export XMODIFIERS=@im=kinput2

# bash_completion
if is_osx; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
	. `brew --prefix`/etc/bash_completion
    fi
fi

## git
alias g='git'
alias gl='git l'
alias gll='git ll'
alias ggl='git gl'
if type -t __git_complete > /dev/null 2>&1; then
    __git_complete g __git_main
fi

if type -t __git_ps1 > /dev/null 2>&1; then
    export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    export GIT_PS1_SHOWDIRTYSTATE=1
fi
    
# lesspipe
export LESSOPEN=''
if [ -x /usr/local/bin/lesspipe.sh ]; then
    eval "$(SHELL=/bin/bash /usr/local/bin/lesspipe.sh)"
elif [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/bash /usr/bin/lesspipe)"    
fi

if [ -n "$LESSOPEN" ] && type pygmentize >/dev/null 2>&1; then
    export LESS='-R'
    export LESSCOLORIZER=pygmentize
fi  

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## direnv
if type direnv > /dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

## include .bashrc_local
if [ -f ~/.bashrc_local ] ; then
    . ~/.bashrc_local
fi
