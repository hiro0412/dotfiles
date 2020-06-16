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

## Adjust PATH
PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
CANDIDATES=(
    "/usr/local/opt/sqlite/bin"  # sqlite
    "/usr/local/opt/binutils/bin"  # GNU binutils
    # "/usr/local/opt/coreutils/libexec/gnubin"  # GNU coreutils
    # "/usr/local/opt/findutils/libexec/gnubin"  # GNU findutils
    "/usr/local/opt/postgresql/bin"
)
for ITEM in "${CANDIDATES[@]}"
do
    if [[ -d "$ITEM" && "$PATH" != *"$ITEM"* ]];
    then
	PATH="$ITEM:$PATH"
    fi
done
export PATH

## Adjust MANPATH
CANDIDATES=(
    "/opt/X11/share/man"
    # "/usr/local/opt/coreutils/libexec/gnuman"  # GNU coreutils
    # "/usr/local/opt/findutils/libexec/gnuman"  # GNU findutils
)
for ITEM in "${CANDIDATES[@]}"
do
    if [[ -d "$ITEM" && "$MANPATH" != *"$ITEM"* ]];
    then
	MANPATH="$ITEM:$MANPATH"
    fi
done
export MANPATH

## bashmarks
if [ -e $HOME/.local/bin/bashmarks.sh ]; then
    source $HOME/.local/bin/bashmarks.sh
fi

