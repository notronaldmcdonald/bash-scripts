#!/usr/bin/env bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# Leave this heading intact if you choose to share the script!

# some variables

store=$HOME/.bmac
RESET=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
currentuser=$(whoami)
if [ -e $store/vars ]; then
  source $store/vars
fi

# initial installation

if [ -e $HOME/.issh-static ]; then
  source $HOME/.issh-static
else
  touch $HOME/.issh-static && echo "export install_refused_user=0" > $HOME/.issh-static
  source $HOME/.issh-static
fi
if [ -e /etc/issh-installed ]; then
  source /etc/issh-installed
else
 echo "Not installed as a system binary."
fi
# after checking for, or creating permanence file to keep special variable.
if [ "$install_refused_user" = "0" ] && [ ! -e /etc/issh-installed ]; then
  read -p "${RESET}Would you like to install the script as a system binary [y/N]?" install_yn
  if [ "$install_yn" = "y" ]; then
    echo "Okay! Starting installation..."
    if [ "${currentuser}" != "root" ]; then
      echo "${RED}${BOLD}Failed${RESET}${RED}: The installation process requires the script to be run as ${BOLD}root!${RESET}"
      echo "In order to run as root, run 'sudo ./simple_ssh.sh'."
      rm -f $HOME/.issh-static
      exit
    else
      echo "Copying to /usr/local/bin/interactive-ssh..."
      cp simple_ssh.sh /usr/local/bin/interactive-ssh
      echo "Installed as system binary. Run 'interactive-ssh' to start the script anywhere."
      echo "export installed=1" > /etc/issh-installed
    fi
  else
    echo "Okay. I won't install myself as a system binary."
    echo "export install_refused_user=1" > $HOME/.issh-static
    echo "Proceeding with script execution now!"
    sleep 1
    echo
  fi
else
  # don't install if user refused the install OR if already installed.
  sleep 1
  echo "you ever just exist?" > /dev/null
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
      read target_user && echo "export target_user_persistent=$target_user" > $store/vars
      echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
      read target_ip && echo "export target_ip_persistent=$target_ip" >> $store/vars
      echo "Next, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
      read target_port && echo "export target_port_persistent=$target_port" >> $store/vars
      echo "Finally, enter the ${BOLD}full directory path ${RESET}of the keyfile."
      read keyfile && echo "export keyfile_persistent=$keyfile" >> $store/vars
      echo "Okay. Connecting with your settings now!"
      ssh -i $keyfile -p $target_port $target_user@$target_ip
    else
      echo Unexpected input received! Exiting... && exit
    fi
  elif [ "$firstrun" != "true" ]; then
    echo "First, enter the username of the account you're trying to access. (ex. foo, root)"
    read target_user && echo "export target_user_persistent=$target_user" > $store/vars
    echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
    read target_ip && echo "export target_ip_persistent=$target_ip" >> $store/vars
    echo "Next, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
    read target_port && echo "export target_port_persistent=$target_port" >> $store/vars
    echo "Finally, enter the ${BOLD}full directory path ${RESET}of the keyfile."
    read keyfile && echo "export keyfile_persistent=$keyfile" >> $store/vars
    echo "Okay. Connecting with your settings now!"
    ssh -i $keyfile -p $target_port $target_user@$target_ip
  else
    echo "An unknown error occurred."
  fi
elif [ "$answer_1" != "${answer_1#[PASSWDpasswd]}" ] || [ "$answer_1" != "${answer_1#[PASSpass]}" ]; then
  if [ "$firstrun" = "true" ]; then
    echo "Would you like to load the previous session settings? Type YES for yes, NO for no."
    read answer
    if [ "$answer" != "${answer#[YESyes]}" ]; then
      ssh -p $target_port_persistent $target_user_persistent@$target_ip_persistent
    elif [ "$answer" != "${answer#[NOno]}" ]; then
      echo "First, enter the username of the account you're trying to access. (ex. foo, root)"
      read target_user && echo "export target_user_persistent=$target_user" > $store/vars
      echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
      read target_ip && echo "export target_ip_persistent=$target_ip" >> $store/vars
      echo "Finally, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
      read target_port && echo "export target_port_persistent=$target_port" >> $store/vars
      echo "Okay. Connecting with your settings now!"
      ssh -p $target_port $target_user@$target_ip
    else
      echo Unexpected input received! Exiting... && exit
    fi
  elif [ "$firstrun" != "true" ]; then
    echo "First, enter the username of the account you're trying to access. (ex. foo, root)"
    read target_user && echo "export target_user_persistent=$target_user" > $store/vars
    echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
    read target_ip && echo "export target_ip_persistent=$target_ip" >> $store/vars
    echo "Finally, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
    read target_port && echo "export target_port_persistent=$target_port" >> $store/vars
    echo "Okay. Connecting with your settings now!"
    ssh -p $target_port $target_user@$target_ip
  fi
elif [ "$answer_1" != "${answer_1#[RESETreset]}" ]; then
  echo "Are you sure you want to reset?"
  read -n1 -r -p "Press ENTER to confirm, CTRL+C to exit."
  echo "Resetting script to shipped state (removing variable files)..."
  rm -f $store/vars $store/firstrun
  echo "Done. Exiting..."
  exit
else
  echo "Unexpected input received! Exiting..." && exit
fi

# end script
