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
    alias ls='ls --color=auto -F'
else
    # osx
    alias ls='ls -GF'
    alias ll='ls -GlT'
    alias llt='ls -GlTt'
    alias lltr='ls -GlTtr'
    alias la='ls -Ga'
    alias lla='ls -GalT'
    alias l1='ls -1'
    alias lR='ls -GFR'
fi
    
## colordiff
if which colordiff > /dev/null;
then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

## tig
if which tig > /dev/null;
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

    # brew
    alias br='brew'

    # mdutil
    alias stopmdutil='sudo mdutil -i off /'
    alias startmdutil='sudo mdutil -i on /'

    # vboxmanage
    VBOXMANAGE_EXEC='/Applications/VirtualBox.app/Contents/MacOS/VBoxManage'
    [ -x "$VBOXMANAGE_EXEC" ] && alias vboxmanage="$VBOXMANAGE_EXEC"
    
elif is_linux; then
    # --- aliases for Linux ---

    # --- Setup to run xwidget on emacs28 on Linux in WSL ---
    #
    # "WEBKIT_FORCE_SANDBOX=0" Launching xwidget without it causes emacs to
    # crash.
    #
    # Since I do not fully understand the impact of the change in the
    # WEBKIT_FORCE_SANDBOX environment variable, wrap it in a function to
    # localize the scope of the impact to emacs only.

    if [ -x ${HOME}/.local/bin/emacs ]; then
	function emacs () {
	    WEBKIT_FORCE_SANDBOX=0 ${HOME}/.local/bin/emacs $*
	}
    fi
fi

## emacs
#alias emacs='emacsclient -nw -c --alternate-editor= '
alias em=emacs
#alias emw='/usr/local/bin/emacs'
#alias emw28='/usr/local/bin/emacs-28'
#alias killemacs='emacsclient -e "(kill-emacs)"'
#alias killem=killemacs

for file in $(ls ~/.bash_aliases.d/aliases* 2>/dev/null)
do
    . $file
done

## popd
alias pd=popd

## aws
if which aws > /dev/null;
then
    alias s3='aws s3'
    alias abatchlog='aws logs filter-log-events --log-group-name /aws/batch/job --log-stream-names'
fi

## virtualenv for python2
alias virtualenv@2='virtualenv -p python2.7'

## for Docker
# referred to this blog: https://tech.anti-pattern.co.jp/peco-de-docker-exec/
if which docker > /dev/null;
then
  alias dps='docker ps'
  alias dimgs='docker images'
  if which peco >/dev/null;
  then
      alias dbash='docker exec -it $(docker ps | peco | awk "{print \$1}") bash'
      alias dlog='docker logs $(docker ps | peco | awk "{print \$1}")'
      alias dstop='docker stop $(docker ps | peco | awk "{print \$1}")'
      alias dkill='docker kill $(docker ps | peco | awk "{print \$1}")'
      alias drm='docker rm $(docker ps -a | peco | awk "{print \$1}")'
  fi
fi
