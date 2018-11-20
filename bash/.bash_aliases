## Anaconda
if [ ! -z "${PYENV_ROOT}" ];
then
    export ANACONDA_ROOT="${PYENV_ROOT}/versions/anaconda3-4.3.1/bin/activate"
    alias activate="source {$ANACONDA_ROOT}"
fi

## ls
if ls --version > /dev/null 2>&1;
then
    # GNU
    alias l='l --color=auto -F'
    alias ls='ls --color=auto -F'
else
    # osx
    alias l='ls -GF'
    alias ls='ls -GF'
    alias ll='ls -GlT'
    alias llt='ls -GlTt'
    alias lltr='ls -GlTtr'
    alias la='ls -Ga'
    alias lla='ls -GalT'
    alias l1='ls -1'
    alias lR='ls -GFR'
fi

## git
alias g='git'
alias gl='git l'
alias gll='git ll'
alias ggl='git gl'


## colordiff
if which -s colordiff;
then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

## tig
if which -s tig;
then
    alias t='tig'
    alias ta='tig --all'
fi

# mysql
# if type mysql >/dev/null 2>&1; then
#     alias mysql_root='MYSQL_PWD=$(cat ${HOME}/MYSQL_PASSWORD) mysql -uroot -hlocalhost --default-character-set=utf8'
# fi

if is_osx; then
    # --- aliases for OSX ---
    
    # mdutil
    alias stopmdutil='sudo mdutil -i off /'
    alias startmdutil='sudo mdutil -i on /'

    # vboxmanage
    VBOXMANAGE_EXEC='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'
    [ -x "$VBOXMANAGE_EXEC" ] && alias vboxmanage="$VBOXMANAGE_EXEC"
    
elif is_linux; then
    # --- aliases for Linux ---
    :
fi

## emacs
alias emacs='emacsclient -c -a ""'
alias killemacs='emacsclient -e "(kill-emacs)"'


for file in $(ls ~/.bash_aliases.d/aliases* 2>/dev/null)
do
    . $file
done
