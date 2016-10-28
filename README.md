```
                        __         __    ___ __ __              
                    .--|  |.-----.|  |_.'  _|__|  |.-----.-----.
                    |  _  ||  _  ||   _|   _|  |  ||  -__|__ --|
                    |_____||_____||____|__| |__|__||_____|_____|


```

Adam's Dotfiles
===============

> you are your dotfiles

My dotfiles are fairly limited in scope, because I don't do everything in 
my terminal.  My terminal use is limited to administration and some small 
amount of development work.

If I decide to run Linux as my primary desktop, this might change.  For 
now my settings are built around using a Windows terminal emulator.

Installation
------------

I manage my dotfiles using GNU Stow. [Here's a good article about stow](http://blog.xero.nu/managing_dotfiles_with_gnu_stow).

This means you should clone this repo into a directory one level above your 
$HOME. After that, you can either run the `./install.sh` or manually install 
each application configuration by typing `stow <application>`.

I recommend at least reviewing the install.sh script, as some of the 
configurations require additional components to be installed - VIM most 
especially.

Fonts & Colours
---------------

I'm currently using a Mono-spaced "Windows Compatible" font from nerd-fonts
that has been patched with all the extra Powerline, Font Awesome, Octicons, 
Devicons, and Vim Devicons.  I've included both the powerline and nerd-fonts
repos as git submodules but your font preference is yours and yours alone.

I've included some popular putty colour schemes as well.

Personal Preferences
--------------------

Personally for my font I like Deja Vu Sans Mono.  For terminal colours I'm 
using a combination of Monokai or Solarized dark, depending on the 
application.

Most of my common applications (zsh, vim, tmux) are using some sort of 
powerline theme for a status bar. 
