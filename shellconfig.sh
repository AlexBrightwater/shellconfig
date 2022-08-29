#!/bin/bash

# make var of conf files to enable custom locations

conf_path=$(pwd)
curr_time=$(date +'%m-%d-%Y_%Hh%Mm')
# Declare files you want to sav(f)e here. Support for dirs coming
declare -a saveme=("zshrc" "bash_aliases" "p10k.zsh" "vimrc"
"tmux.conf" )

######################################################
# make backup of current conf state for easy restore #
######################################################
function backup () {
if [[ ! -d $conf_path/.BAK ]]; then
	mkdir $conf_path/.BAK
fi

if [[ ! -d $conf_path/.BAK/$curr_time ]]; then
	mkdir  $conf_path/.BAK/$curr_time

	for val in "${saveme[@]}"; do
		cat ~/.$val > $conf_path/.BAK/$curr_time/.$val
	done

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

	for val in "${saveme[@]}"; do
		cat $conf_path/$val > ~/.$val 
	done

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
	for val in "${saveme[@]}"; do
		cat $latest/.$val > ~/.$val 
	done
	
	echo "Restore complete"
	exit 0
}

########
# HELP #
########
function help_message () {
	echo "You have just a few options. "
	echo "+---------------------------------------+"
	echo "| -i | Create a backup and install      |"
	echo "| -b | Create a backup                  |"
	echo "| -o | Install w/o creating a backup    |"
	echo "| -r | Restore from last backup         |"
	echo "| -h | For this help page               |"
	echo "+---------------------------------------+"
	echo "This script belongs to Alex Brightwater on GitHub."
	echo "> https://github.com/AlexBrightwater/shellconfig"
}


###################
# Asks what to do #
###################
function set_option () {
	read -p "What do you want to do with the script? Insert h if for help. (iborh) " loption
	case $loption in
		i|install)	backup; install;;
		b|backup)	backup;;
		o|nobackup)	install;;
		r|restore)	restore_promt;;
		h|help)		help_message;;
		\?)		echo "Error: Didn't copy start_ssh.sh anywhere.";; 
	esac
	
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
	h)	help_message;;
  	\?)	echo "Error: Didn't copy start_ssh.sh anywhere.";; 
   esac
	exit 0
done

set_option
