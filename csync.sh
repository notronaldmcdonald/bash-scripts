#!/usr/bin/env bash
# Developed by Brett. (https://github.com/notronaldmcdonald)
# For personal use. If you have this script, you aren't allowed to redistribute it without asking.

# begin script

echo "This script will download all of your shell configuration files from a remote repo, and place them in their destinations."
read -n1 -r -p "Press ENTER to continue."
cd $HOME
git clone https://github.com/notronaldmcdonald/bash-scripts/
cd bash-scripts/
rm *.sh *.md
echo Removing uneccessary files...
cp .zprofile $HOME/.zprofile
cp .zshrc $HOME/.zshrc
cp .bashrc $HOME/.bashrc
cp .bash_profile $HOME/.bash_profile
echo Moved all files to the home folder.
cd $HOME
echo Cleaning up...
rm -r bash-scripts/
echo Finished.

# end script
