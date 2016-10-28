# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
WORKON_HOME=~/.pyenvs
GIT_EDITOR=vim

export WORKON_HOME
export PATH
export GIT_EDITOR

source /usr/bin/virtualenvwrapper.sh
source ~/.bashsecrets

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
