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

	echo "Backup created in $conf_path/.BAK/$curr_time/ \n"
	
else 
	echo "Could't create Backup, please try again in 1 minute."
	exit
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
	echo "cloned p10k files to ~/powerlevel10k \n"
else
	echo "p10k files already exist \n"
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
	read -p "Continue do you really want to restore your current dot files? (y/n)" choice
	case "$choice" in 
  		y|Y ) echo "yes";;
  		n|N ) echo "no";;
  		* ) echo "invalid";;
	esac
}

function restore_do () {
	latest=$(ls -td $conf_path/.BAK/$curr_time/* | head -1)
	print "$latest"
	#for file in "$latest"/*; do
	#	cp $conf_path/BAK/$latest/.zshrc ~/.zshrc
	#	cp $conf_path/BAK/$latest/.bash_aliases ~/.bash_aliases  
	#	cp $conf_path/BAK/$latest/.p10k.zsh ~/.p10k.zsh
	#	cp $conf_path/BAK/$latest/.vimrc ~/.vimrc
	#done
	
}

###############################################
# get options and run the specified functions #
###############################################

while getopts ":iborh" option; do
   case $option in
	i)	backup; install;;
	b)	backup;;
	o)	install;;
	r)	restore_promt; restore_do;;
	h)	echo "help not implemented yet";;
  	\?)	echo "Error: Didn't copy start_ssh.sh anywhere.";;  
   esac
done

