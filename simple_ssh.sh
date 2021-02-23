#!/bin/bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# Leave this heading intact if you choose to share the script!

# some variables

store=$HOME/.bmac
RESET=$(tput sgr0)
BOLD=$(tput bold)
if [ -e $store/vars ]; then
  source $store/vars
fi

# firstrun checks

echo "${RESET}Starting..."
if [ -e $store ]; then
  echo Successfully found user variables folder.
else
  echo User variables folder not found. Creating now...
  mkdir $HOME/.bmac
  echo Directory created at "$HOME/.bmac". This directory will be used across all scripts.
fi
if [ -e $store/firstrun ]; then
  source $store/firstrun
else
  echo "${RESET}Creating firstrun file..."
  touch $store/firstrun
  echo "export firstrun=true" > $store/firstrun
  echo "Done!"
fi

# begin script

echo ${RESET}Welcome to SimpleSSH! This script is designed to make using OpenSSH slightly more user friendly.
echo "Do you use key-based or password based authentication? Type KEY if you use keyfiles, or PASSWD for password."
read answer_1
if [ "$answer_1" != "${answer_1#[KEYkey]}" ]; then
  if [ "$firstrun" = "true" ]; then
    echo "Would you like to load the previous session settings? Type YES for yes, NO for no."
    read answer
    if [ "$answer" != "${answer#[YESyes]}" ]; then
      ssh -i $keyfile_persistent -p $target_port_persistent $target_user_persistent@$target_ip_persistent
    elif [ "$answer" != "${answer#[NOno]}" ]; then
      echo "Okay! First, enter the username of the account you're trying to access. (ex. foo, root)"
      read target_user && echo "export target_user_persistent=$target_user" > .vars
      echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
      read target_ip && echo "export target_ip_persistent=$target_ip" >> .vars
      echo "Next, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
      read target_port && echo "export target_port_persistent=$target_port" >> .vars
      echo "Finally, enter the ${BOLD}full directory path ${RESET}of the keyfile."
      read keyfile && echo "export keyfile_persistent=$keyfile" >> .vars
      echo "Okay. Connecting with your settings now!"
      ssh -i $keyfile -p $target_port $target_user@$target_ip
    else
      echo Unexpected input received! Exiting... && exit
    fi
  elif [ "$firstrun" != "true" ]; then
    echo "First, enter the username of the account you're trying to access. (ex. foo, root)"
    read target_user && echo "export target_user_persistent=$target_user" > .vars
    echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
    read target_ip && echo "export target_ip_persistent=$target_ip" >> .vars
    echo "Next, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
    read target_port && echo "export target_port_persistent=$target_port" >> .vars
    echo "Finally, enter the ${BOLD}full directory path ${RESET}of the keyfile."
    read keyfile && echo "export keyfile_persistent=$keyfile" >> .vars
    echo "Okay. Connecting with your settings now!"
    ssh -i $keyfile -p $target_port $target_user@$target_ip
  else
    echo "An unknown error occurred."
  fi
elif [ "$answer_1" != "${answer_1#[PASSWDpasswd]}" ]; then
  if [ "$firstrun" = "true" ]; then
    echo "Would you like to load the previous session settings? Type YES for yes, NO for no."
    read answer
    if [ "$answer" != "${answer#[YESyes]}" ]; then
      ssh -p $target_port_persistent $target_user_persistent@$target_ip_persistent
    elif [ "$answer" != "${answer#[NOno]}" ]; then
      echo "First, enter the username of the account you're trying to access. (ex. foo, root)"
      read target_user && echo "export target_user_persistent=$target_user" > .vars
      echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
      read target_ip && echo "export target_ip_persistent=$target_ip" >> .vars
      echo "Finally, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
      read target_port && echo "export target_port_persistent=$target_port" >> .vars
      echo "Okay. Connecting with your settings now!"
      ssh -p $target_port $target_user@$target_ip
    else
      echo Unexpected input received! Exiting... && exit
    fi
  elif [ "$firstrun" != "true" ]; then
    echo "First, enter the username of the account you're trying to access. (ex. foo, root)"
    read target_user && echo "export target_user_persistent=$target_user" > .vars
    echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
    read target_ip && echo "export target_ip_persistent=$target_ip" >> .vars
    echo "Finally, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
    read target_port && echo "export target_port_persistent=$target_port" >> .vars
    echo "Okay. Connecting with your settings now!"
    ssh -p $target_port $target_user@$target_ip
  fi
fi

# end script
