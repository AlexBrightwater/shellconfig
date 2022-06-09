#!/bin/bash
if [[ ! -d ~/powerleevl10k ]]
then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	sleep 5
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
else
	echo "p10k already exists"
fi

if [[ ! -d ~/priv/repos/shellconfig ]]
then
	git clone https://github.com/AlexBrightwater/shellconfig.git ~/priv/repos/shellconfig
	sleep 5
else
	cd ~/priv/repos/shellconfig
	git pull ~/priv/repos/shellconfig
fi

cat ~/priv/repos/shellconfig/zshrc > ~/.zshrc
cat ~/priv/repos/shellconfig/bash_aliases > ~/.bash_aliases
cat ~/priv/repos/shellconfig/p10k.zsh > ~/.p10k.zsh
cat ~/priv/repos/shellconfig/vimrc > ~/.vimrc

