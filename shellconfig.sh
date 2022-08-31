#!/bin/bash

# make var of conf files to enable custom locations
repo_path=$(pwd)
curr_time=$(date +'%m-%d-%Y_%Hh%Mm')

# Declare what you want to save to git
# files and directories must be dotfiles
declare -a files=("zshrc" "bash_aliases" "p10k.zsh" "vimrc"
"tmux.conf" )
declare -a dirs=(test)

# TODO
# package support
# 	Detect system or use input
# Directry Support -> Done?
# in zshrc add theme correctly
# zsh plugins
# only keep 5 backups
# get tmux working

# Insterting to specific line: sed -i '2 i content here' filehere 

######################################################
# make backup of current conf state for easy restore #
######################################################
function backup () {
if [[ ! -d $repo_path/.BAK ]]; then
	mkdir $repo_path/.BAK
fi

if [[ ! -d $repo_path/.BAK/$curr_time ]]; then
	mkdir  $repo_path/.BAK/$curr_time

	for val in "${files[@]}"; do
		if [[ -f ~/.$val ]]; then
			cat ~/.$val > $repo_path/.BAK/$curr_time/.$val
		fi
	done
	for val in "${dirs[@]}"; do
		if [[ -d ~/.$val ]]; then
			cp -r ~/.$val $repo_path/.BAK/$curr_time/.$val
		fi
	done

	echo "Backup created in $repo_path/.BAK/$curr_time/"
else 
	echo "Could't create Backup, please try again in 1 minute."
	exit 1
fi
}

###############################
#  populate the config files  #
###############################
function install () {
	for val in "${files[@]}"; do
		cat $repo_path/$val > ~/.$val 
	done
	for val in "${dirs[@]}"; do
		if [[ -d ~/.$val ]]; then
			cp -r $repo_path/$val ~/.$val
		fi
	done

	echo "Finished populating config files from $repo_path to home dir."
}

# Get powerlevel10k
function powerlevel () {
	if [[ ! -d ~/powerlevel10k ]]
	then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
		echo "Cloned p10k files to ~/powerlevel10k"
	else
		echo "Files for p10k already exist"
	fi
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
	latest=$(ls -td $repo_path/.BAK/* | head -1)
	for val in "${files[@]}"; do
		if [[ -f ~/.$val ]]; then
			cat $latest/.$val > ~/.$val
		fi
	done
	for val in "${dirs[@]}"; do
		if [[ -d ~/.$val ]]; then
			cp -r $latest/.$val ~/.$val
		fi
	done	
	
	echo "Restore complete"
	exit 0
}

########
# HELP #
########
function help_message () {
	echo "Under construction again"
	#echo "You have just a few options. "
	#echo "+---------------------------------------+"
	#echo "| -i | Create a backup and install      |"
	#echo "| -b | Create a backup                  |"
	#echo "| -o | Install w/o creating a backup    |"
	#echo "| -r | Restore from last backup         |"
	#echo "| -h | For this help page               |"
	#echo "+---------------------------------------+"
	#echo "This script belongs to Alex Brightwater on GitHub."
	#echo "> https://github.com/AlexBrightwater/shellconfig"
}

###################
# Asks what to do #
###################
function no_options () {
	echo "Please execute the script again and provide arguments."
	echo "Use -h for help"
	exit 0
}

while :; do
    case $1 in
        -i|--install) backup; install;;
        -b|--backup) backup;;
        -o|--nobackup) install;;
        -r|--restore) restore_promt;;
		-p|--powerlevel10k) powerlevel;;
        -h|--help) help_message;;
        *) break
    esac
    shift
done
exit 0

no_options
