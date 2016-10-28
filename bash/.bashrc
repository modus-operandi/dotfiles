# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export TERM=xterm-256color

# User specific aliases and functions
alias vi='vim'
alias syn='synergys -f -n uber > /dev/null 2> /dev/null &'
alias memcheck='ps -e -o pid,vsz,comm= | sort -n -k 2'
alias topmem='ps -eorss,args | sort -nr | pr -TW$COLUMNS | head'
alias upgrade_ansible='sudo pip install --upgrade ansible'
alias downgrade_ansible='sudo pip uninstall ansible ;  sudo pip install ansible==1.9.2'
alias websrv='python -m SimpleHTTPServer'
alias mirrorweb='wget --random-wait -r -p -e robots=off -U mozilla'
alias findupe='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'

# Git color prompt
export COLOR_RED="\033[0;31m"
export COLOR_YELLOW="\033[0;33m"
export COLOR_GREEN="\033[0;32m"
export COLOR_OCHRE="\033[38;5;95m"
export COLOR_BLUE="\033[0;34m"
export COLOR_WHITE="\033[0;37m"
export COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

PS1="\[$COLOR_WHITE\]>"          # basename of pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_BLUE\]\[$COLOR_RESET\] "   # '#' for root, else '$'
PS1+="[\u@\h \W]\$ "
export PS1
