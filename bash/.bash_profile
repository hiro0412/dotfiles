if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

## for Java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

## pyenv settings ##
if [ -d "${HOME}/.pyenv" ];
then
   export PYENV_ROOT="${HOME}/.pyenv"
   #export PATH="${PYENV_ROOT}/bin:$PATH"
   #eval "$(pyenv init -)"
fi

## android-tools
if [ -d $HOME/Library/Android/sdk/platform-tools ];
then
    export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
fi

## Google Cloud SDK Settings ##
if [ -d "${HOME}/google-cloud-sdk" ];
then
    GCSDK_HOME="${HOME}/google-cloud-sdk"
    
    # The next line updates PATH for the Google Cloud SDK.
    if [ -f "${GCSDK_HOME}/path.bash.inc" ];
    then
	source "${GCSDK_HOME}/path.bash.inc";
    fi

    # The next line enables shell command completion for gcloud.
    if [ -f "${GCSDK_HOME}/completion.bash.inc" ];
    then
	source "${GCSDK_HOME}/completion.bash.inc";
    fi
fi

## adjust path
PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
if [ -d "/usr/local/opt/sqlite/bin" ];
then
    PATH="/usr/local/opt/sqlite/bin:$PATH"
fi
export PATH
