#!/usr/bin/env bash
# Developed by Brett. (https://github.com/notronaldmcdonald)
# Because apt is shitty.

# variables and functions
source $HOME/.bashrc
dir=$(pwd)
aptupgrade () {
  apt-get update
  apt-get upgrade
}

# begin script

if [ "$add_config" = "false" ]; then
  read -p "Write as alias 'sysupdate' to user config [y/N]?" answer
    if [ "$answer" = "y" ]; then
      echo "alias sysupdate='./${dir}/apt_update.sh'" >> $HOME/.bashrc
      echo "add_config=true" >> $HOME/.bashrc
      echo "Appended to .bashrc."
      aptupgrade
    else
      aptupgrade
    fi
elif [ "$add_config" = "true" ]; then
  aptupgrade
fi
# seriously tho i cant believe this is a two command process thats actually bad

# end script
