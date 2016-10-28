# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
WORKON_HOME=~/.pyenvs

SLACK_BOT_TOKEN=argh
BOT_ID=iamnotasmartman

export WORKON_HOME
export PATH
export SLACK_BOT_TOKEN
export BOT_ID

source /usr/bin/virtualenvwrapper.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
