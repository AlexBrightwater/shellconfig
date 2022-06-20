#!/bin/bash
if [[ ! -d ~/powerlevel10k ]]
then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
else
	echo "p10k already exists"
fi

if [[ -d ~/priv/repos/shellconfig ]]; then
	cd ~/priv/repos/shellconfig/
	git pull ~/priv/repos/shellconfig
	path='priv/repos/shellconfig'
elif [[ -d ~/Repositories/shellconfig ]]; then
	cd ~/Repositories/shellconfig/
	git pull ~/Repositories/shellconfig
	path='Repositories/shellconfig'
elif [[ -d ~/.shellconfig ]]; then
	cd ~/.shellconfig/
	git pull ~/.shellconfig
	path='.shellconfig'
fi

cat ~/${path}/zshrc > ~/.zshrc
cat ~/${path}/bash_aliases > ~/.bash_aliases
cat ~/${path}/p10k.zsh > ~/.p10k.zsh
cat ~/${path}/vimrc > ~/.vimrc
echo "Finished populating config files from repo in ~/${path}."

while getopts ":s" option; do
   case $option in
	s) cat ~/${path}/start_ssh.sh > ~/.start_ssh.sh
	   echo "Finished enabeling ssh-agent on startup.";;
  	\?) echo "Error: Didn't copy start_ssh.sh anywhere.";;  
   esac
done

