if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi


## bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

## for Java
export JAVA_HOME=$(/usr/libexec/java_home -v 9)

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
# PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
CANDIDATES=(
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/local/opt/sqlite/bin"  # sqlite
    "/usr/local/opt/binutils/bin"  # GNU binutils
    # "/usr/local/opt/coreutils/libexec/gnubin"  # GNU coreutils
    # "/usr/local/opt/findutils/libexec/gnubin"  # GNU findutils
    "/usr/local/opt/postgresql/bin"
    "/usr/local/opt/texinfo/bin"  # texinfo
    "${HOME}/.local/bin"
    "${HOME}/go/bin"
    "${HOME}/phabricator/arcanist/bin"
    "${HOME}/bin"
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

# ## openssl 1.1
# if [ -d "/usr/local/opt/openssl@1.1/bin" ]; then
#    export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# fi

## Suppress warning mesage on bash on Catalina ( https://support.apple.com/ja-jp/HT208050 )
if is_osx; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi
