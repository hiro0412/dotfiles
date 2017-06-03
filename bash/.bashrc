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

export EDITOR='emacs -q -nw'

export LANG=ja_JP.UTF-8
export XMODIFIERS=@im=kinput2

export MANPATH=/opt/X11/share/man:$MANPATH

alias stopmdutil='sudo mdutil -i off /'
alias startmdutil='sudo mdutil -i on /'

alias vboxmanage='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'

# alias activate="source ${PYENV_ROOT}/versions/anaconda3-4.3.1/bin/activate"

# coreutils
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# export PATH=/usr/local/mysql/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
# export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# virtualenvwrapper
# export PROJECT_HOME=$HOME/projects
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

# mysql
# alias mysql_root='MYSQL_PWD=$(cat ${HOME}/MYSQL_PASSWORD) mysql -uroot -hlocalhost --default-character-set=utf8'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# direnv
eval "$(direnv hook bash)"
