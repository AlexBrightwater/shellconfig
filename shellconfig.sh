#!/bin/bash
# make var of conf files to enable custom locations

conf_path=$(pwd)
curr_time=$(date +'%m-%d-%Y_%Hh%Mm')

######################################################
# make backup of current conf state for easy restore #
######################################################
function backup () {
if [[ ! -d $conf_path/.BAK ]]; then
	mkdir $conf_path/.BAK
fi

if [[ ! -d $conf_path/.BAK/$curr_time ]]; then
	mkdir  $conf_path/.BAK/$curr_time

	cp ~/.zshrc $conf_path/.BAK/$curr_time/ 
	cp ~/.bash_aliases $conf_path/.BAK/$curr_time/
	cp ~/.p10k.zsh $conf_path/.BAK/$curr_time/
	cp ~/.vimrc $conf_path/.BAK/$curr_time/

	echo "Backup created in $conf_path/.BAK/$curr_time/"
	
else 
	echo "Could't create Backup, please try again in 1 minute."
	exit 1
fi
}

######################################################
# make backup of current conf state, clone p10k and  #
#  populate the config files                         #
######################################################
function install () {
if [[ ! -d ~/powerlevel10k ]]
then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo "Cloned p10k files to ~/powerlevel10k"
else
	echo "Files for p10k already exist"
fi

cp $conf_path/zshrc ~/.zshrc
cp $conf_path/bash_aliases ~/.bash_aliases
cp $conf_path/p10k.zsh ~/.p10k.zsh
cp $conf_path/vimrc ~/.vimrc

echo "Finished populating config files from $conf_path to home dir."

}

########################
# Restore from backup  #
########################
function restore_promt () {
	read -p "Do you really want to continiue with the restore from backup? (y/n) " choice
	case "$choice" in 
  		y|Y ) echo "Continuing with the restore process"; restore_do;;
  		n|N ) echo "Aborting the restore process"; exit 0;;
  		* ) echo "The answer was invalid. Please try again"; restore_promt ;;
		
	esac
}

function restore_do () {
	latest=$(ls -td $conf_path/.BAK/* | head -1)
	cp $latest/.zshrc ~/.zshrc
	cp $latest/.bash_aliases ~/.bash_aliases
	cp $latest/.p10k.zsh ~/.p10k.zsh
	cp $latest/.vimrc ~/.vimrc
	
	echo "Restore complete"
	exit 0
}

###############################################
# get options and run the specified functions #
###############################################
while getopts ":iborh" option; do
   case $option in
	i)	backup; install;;
	b)	backup;;
	o)	install;;
	r)	restore_promt;;
	h)	echo "help not implemented yet";;
  	\?)	echo "Error: Didn't copy start_ssh.sh anywhere.";;  
   esac
done

