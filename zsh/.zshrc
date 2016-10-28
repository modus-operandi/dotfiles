# Modified by drot 

# {{{ User settings

# {{{ Environment
export LANG=en_US.UTF8
export PATH=$PATH:~/bin
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export SHELL="zsh"
export LESSHISTFILE="-"
export PAGER="less"
export VISUAL="vim"
export EDITOR=$VISUAL
export BROWSER="chromium"
export GIT_EDITOR=vim
#export TERM="xterm-256color"
# }}}

# {{{ Dircolors
eval `dircolors -b ~/.dircolors`
# }}}

# {{{ Manual pages
#     - colorize, since man-db fails to do so
export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline
# }}}

# {{{ Aliases
alias ls='ls --color'
alias vi='vim'
# }}}

# {{{ Functions
function extract () {
    if [[ -z "$1" ]]; then
        print -P "Usage: extract filename"
        print -P "Extract a given file based on the extension."
    elif [[ -f "$1" ]]; then
        case "$1" in
            *.tbz2 | *.tar.bz2) tar -xvjf  "$1"     ;;
            *.txz | *.tar.xz)   tar -xvJf  "$1"     ;;
            *.tgz | *.tar.gz)   tar -xvzf  "$1"     ;;
            *.tar | *.cbt)      tar -xvf   "$1"     ;;
            *.zip | *.cbz)      unzip      "$1"     ;;
            *.rar | *.cbr)      unrar x    "$1"     ;;
            *.bz2)              bunzip2    "$1"     ;;
            *.xz)               unxz       "$1"     ;;
            *.gz)               gunzip     "$1"     ;;
            *.7z)               7z x       "$1"     ;;
            *.Z)                uncompress "$1"     ;;
            *) echo "Error: failed to extract '$1'" ;;
        esac
    else
        echo "Error: '$1' is not a valid file for extraction"
    fi
}
# }}}

# {{{ ZSH settings
setopt vi
setopt nohup
setopt autocd
setopt cdablevars
setopt ignoreeof
setopt nobgnice
setopt nobanghist
setopt noclobber
setopt shwordsplit
setopt interactivecomments
setopt autopushd pushdminus pushdsilent pushdtohome
setopt histreduceblanks histignorespace inc_append_history
#
# new style completion system
autoload -U compinit; compinit
# list of completers to use
zstyle ':completion:*' completer _complete _match _approximate
# allow approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# selection prompt as menu
zstyle ':completion:*' menu select=1
# menuselection for pid completion
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
# cd don't select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd
# complete with colors
zstyle ':completion:*' list-colors ''
# }}}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

function aws-instances-describe() {
    zparseopts -D -E -A opts -- o: t: s:
    output=${opts[-o]:-"table"}
    tag_name=${opts[-t]:-"Name"}
    state=${opts[-s]:-"running"}

    name=${1}
    query=(
        "Reservations[].Instances[]"
        ".{"
        "Name             : Tags[?Key == \`Name\`].Value | [0],"
        "Environment      : Tags[?Key=='Environment'].Value | [0],"
        "State            : State.Name,"
        "LaunchTime       : LaunchTime,"
        "InstanceId       : InstanceId,"
        "PrivateIpAddress : PrivateIpAddress,"
        "PublicIpAddress  : PublicIpAddress,"
        "ImageId          : ImageId,"
        "InstanceType     : InstanceType"
        "}"
    )

    aws --output ${output} \
        ec2 describe-instances \
        --filters "Name=tag:${tag_name},Values=*${name}*" "Name=instance-state-name,Values=${state}" \
        --query "${query}"
}

function aws-list-all() {
    zparseopts -D -E -A opts -- o: s:
    output=${opts[-o]:-"table"}
    state=${opts[-s]:-"running"}

    query=(
        "Reservations[].Instances[]"
        ".{"
        "Name             : Tags[?Key=='Name'].Value | [0],"
        "Services         : Tags[?Key=='Services'].Value | [0],"
        "Environment      : Tags[?Key=='Environment'].Value | [0],"
        "State            : State.Name,"
        "LaunchTime       : LaunchTime,"
        "PublicIpAddress  : PublicIpAddress,"
        "PrivateIpAddress : PrivateIpAddress,"
        "ImageId          : ImageId,"
        "InstanceType     : InstanceType"
        "}"
    )

    aws --output ${output} \
        ec2 describe-instances \
        --filters "Name=instance-state-name,Values=${state}" \
        --query "${query}"
}

function aws-list-linux() {
   aws-instances-describe -t Environment ${1:-Staging} | grep -e '.*l[0-9][0-9].ue.*'
}

function aws-images-describe()
{
    zparseopts -D -E -A opts -- o:
    output=${opts[-o]:-"table"}

    id=${1:-ami-e3106686}
    aws --output ${output} \
        ec2 describe-images \
        --image-ids "${id}"
}

function s3du() {
    s3cmd du s3://${1} | awk '{print $0/1024/1024/1024" GB"}'
}

# find the latest snapshot given a volume-id
function find-snap() {
    aws ec2 describe-snapshots --filter 'Name=volume-id,Values=${1}' | jq '.[]|max_by(.StartTime)|.SnapshotId'
}

source ~/.powerlevel9k/powerlevel9k.zsh-theme 
source /usr/bin/virtualenvwrapper.sh
source ~/.zshsecrets

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time load ram virtualenv)
