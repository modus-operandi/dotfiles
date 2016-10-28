#!/bin/bash

files="bash bin dircolors git screen tmux vim zsh"

for i in `echo $files`
do
    echo "Processing application settings - $i.."
      stow $i
done

echo "[*] Installing system level requirements"
sudo yum install stow cmake gcc-c++
sudo pip install powerline-status

echo "[*] Installing zsh requirements."
cd zsh
git clone https://github.com/bhilburn/powerlevel9k.git .powerlevel9k

echo "[*] Installing VIM plugins."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
echo "[*] Installing vim requirements."
cd ../vim
git clone https://github.com/Valloric/ycmd.git
cd ycmd/third_party
git submodule update --init --recursive
cd ..
# if this fails to build on centos6.x, please see this: 
# -- problem: https://github.com/Valloric/YouCompleteMe/issues/2227
# -- solution: https://gist.github.com/stephenturner/e3bc5cfacc2dc67eca8b
# OR just remove the ./vim/ycmd folder, uncomment these lines below and re-run the script:
# sudo rpm --import http://ftp.scientificlinux.org/linux/scientific/5x/x86_64/RPM-GPG-KEYs/RPM-GPG-KEY-cern
# sudo wget -O /etc/yum.repos.d/slc6-devtoolset.repo http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo
# sudo yum -y install devtoolset-2
# source /opt/rh/devtoolset-2/enable
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
