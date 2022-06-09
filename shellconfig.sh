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
	
	cat ~/priv/repos/shellconfig/zshrc > ~/.zshrc
	cat ~/priv/repos/shellconfig/bash_aliases > ~/.bash_aliases
	cat ~/priv/repos/shellconfig/p10k.zsh > ~/.p10k.zsh
	cat ~/priv/repos/shellconfig/vimrc > ~/.vimrc
	echo "Finished populating config files from repo in ~/priv/repos/shellconfig/."
elif [[ -d ~/Repositories/shellconfig ]]; then
	cd ~/Repositories/shellconfig/
	git pull ~/Repositories/shellconfig
	
	cat ~/Repositories/shellconfig/zshrc > ~/.zshrc
	cat ~/Repositories/shellconfig/bash_aliases > ~/.bash_aliases
	cat ~/Repositories/shellconfig/p10k.zsh > ~/.p10k.zsh
	cat ~/Repositories/shellconfig/vimrc > ~/.vimrc
	echo "Finished populating config files from repo in ~/Repositories/shellconfig/."
elif [[ -d ~/.shellconfig ]]; then
	cd ~/.shellconfig/
	git pull ~/.shellconfig
	
	cat ~/.shellconfig/zshrc > ~/.zshrc
	cat ~/.shellconfig/bash_aliases > ~/.bash_aliases
	cat ~/.shellconfig/p10k.zsh > ~/.p10k.zsh
	cat ~/.shellconfig/vimrc > ~/.vimrc
	echo "Finished populating config files from repo in ~/.shellconfig/."
fi
