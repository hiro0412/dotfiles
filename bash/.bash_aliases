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

## colordiff
if which -s colordiff;
then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi
