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

## --  https://qiita.com/xtetsuji/items/31bc53e92d94b1602b5d
# 履歴を記録する cd の再定義
function cd {
    if [ -z "$1" ] ; then
        # cd 連打で余計な $DIRSTACK を増やさない
        test "$PWD" != "$HOME" && pushd $HOME > /dev/null
    elif ( echo "$1" | egrep "^\.\.\.+$" > /dev/null ) ; then
        cd $( echo "$1" | perl -ne 'print "../" x ( tr/\./\./ - 1 )' )
    else
        pushd "$1" > /dev/null
    fi
}

# ショートカットキーで移動するcd
function cdj {
    ### cdjはCDJ_DIR_MAPという環境変数の配列の定義が必要です
    # CDJ_DIR_MAP配列の例は以下です。ディレクトリのエイリアスと実ディレクトリのパスを空白区切りでペアで書いていきます
#     export CDJ_DIR_MAP=(
#         dbox ~/Dropbox
#         cvs  ~/cvs
#         etc  /etc
#         );
    test -n "$DEBUG" && echo "DEBUG: dir arg=$arg #CDJ_DIR_MAP=${#CDJ_DIR_MAP[*]}" 
    declare arg=$1 \
            subarg=$2 \
            dir i key value warn
    if [ -z "$arg" -o "$arg" = "-h" ] || [ "$arg" = "-v" -a -z "$subarg" ] ; then
        ### help and usage mode
        echo "Usage: $FUNCNAME <directory_alias>"
        echo "       $FUNCNAME [-h|-v|-l <directory_alias>]"
        echo "-h: help"
        echo "-l: list defined lists"
        echo "-v <directory_alias>: view path specify alias."
        return
    elif [ "$arg" = "-v" -o "$arg" = "-l" ] ; then 
        ### view detail mode
        for (( i=0; $i<${#CDJ_DIR_MAP[*]}; i=$((i+2)) )) ; do
            key="${CDJ_DIR_MAP[$i]}"
            value="${CDJ_DIR_MAP[$((i+1))]}"
            if [ "$arg" = "-l" ] ; then
                if [ ! -d "$value" ] ; then
                    warn=" ***NOT_FOUND***"
                else
                    warn=""
                fi
                printf "%8s => %s%s\n" "$key" "$value" "$warn"
            elif [ "$arg" = "-v" ] ; then
                if [ "$key" = "$subarg" ] ; then
                    echo $value
                    return
                fi
            fi
        done
        return
    fi
    ### change directory mode
    for (( i=0; $i<${#CDJ_DIR_MAP[*]}; i=$((i+2)) )) ; do
        key="${CDJ_DIR_MAP[$i]}"
        value="${CDJ_DIR_MAP[$((i+1))]}"
        test -n "$DEBUG" && echo "$key => $value"
        if [ "$key" = "$arg" ] ; then
            if [ -n "$subarg" ] ; then
                dir="$value/$subarg"
            else
                dir="$value"
            fi
            cd "$dir"
            return
        fi
    done
    echo "directory alias \"$arg\" is not found"
    return 1
}
