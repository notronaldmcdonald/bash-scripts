#!/bin/bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# Leave this heading intact if you choose to share the script!

# some variables - this section has become a standard i use when writing scripts.
# it's used to store global variables that aren't updated during runtime. in this case, it stores the location of the user variables folder, and formatting info.
# it also checks for the variables file, which is related

store=$HOME/.bmac
RESET=$(tput sgr0)
BOLD=$(tput bold)
if [ -e $store/vars ]; then
  source $store/vars
fi

# runtime checks - this section is designed to improve usability. it checks for the existence of the aforementioned files.

echo "${RESET}Starting..."
if [ -e $store ]; then
  echo Successfully found user variables folder.
else
  echo User variables folder not found. Creating now...
  mkdir $HOME/.bmac # mkdir, or make directory, is a more or less universal shell command. it creates a directory (folder) on your computer.
  # in this case, it creates a hidden folder (denoted by the '.' before its name in the home directory, which is defined by the environment variable $HOME)
  echo Directory created at "$HOME/.bmac". This directory will be used across all scripts.
fi
if [ -e $store/firstrun ]; then
  source $store/firstrun
else
  echo "${RESET}Creating firstrun file..."
  touch $store/firstrun
  echo "export firstrun=true" > $store/firstrun # this is the first example of redirection in the script.
  # command redirection does what it sounds like; it takes the output of a command and sends it somewhere else. there are a few different ways this works.
  # in this example, it takes the output of the echo command, which is the specified text, and puts it in a file in the variables folder defined previously.
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
    if [ "$answer" != "${answer#[YESyes]}" ]; then # this is the first semi-advanced feature in the script - persistent data storage. i'll go into it more as it becomes relevant.
      ssh -i $keyfile_persistent -p $target_port_persistent $target_user_persistent@$target_ip_persistent # ssh stands for secure shell, a remote access utility.
    elif [ "$answer" != "${answer#[NOno]}" ]; then
      echo "Okay! First, enter the username of the account you're trying to access. (ex. foo, root)"
      read target_user && echo "export target_user_persistent=$target_user" > $store/vars # here you'll see a few things happen on the same line.
      # the first of these things is the read command, which is discussed in the sync script's comments. if that command doesn't fail (which it won't), then an echo command is run.
      # this takes the variable the user just set with the read command and echoes it to a file.
      echo "Now, enter the IP address of the computer you're trying to connect to. (If you're on a local network, this will be a local ip address.)"
      read target_ip && echo "export target_ip_persistent=$target_ip" >> $store/vars # on this line, its a bit different. using one '>' character overwrites all data in the file.
      # however, with two of those characters, it appends the output to the file.
      echo "Next, enter the port the SSH daemon is bound to on the target machine. (The default is 22. If you haven't changed it, enter 22.)"
      read target_port && echo "export target_port_persistent=$target_port" >> $store/vars
      echo "Finally, enter the ${BOLD}full directory path ${RESET}of the keyfile."
      read keyfile && echo "export keyfile_persistent=$keyfile" >> $store/vars
      echo "Okay. Connecting with your settings now!"
      ssh -i $keyfile -p $target_port $target_user@$target_ip
    else
      echo Unexpected input received! Exiting... && exit # exit ends a script prematurely.
    fi
  elif [ "$firstrun" != "true" ]; then # here, you can see what happens if the 'firstrun' variable is NOT true. this skips the option to load previous session data.
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
    echo "An unknown error occurred." && exit
  fi
elif [ "$answer_1" != "${answer_1#[PASSWDpasswd]}" ]; then
  if [ "$firstrun" = "true" ]; then
    echo "Would you like to load the previous session settings? Type YES for yes, NO for no."
    read answer
    if [ "$answer" != "${answer#[YESyes]}" ]; then
      ssh -p $target_port_persistent $target_user_persistent@$target_ip_persistent # now, we can talk about how the persistent data is stored.
      # as you saw with the redirection, it sends that information to a file. if you scroll back up, you see that the script uses a command called 'source'.
      # that takes variables and other commands from the targeted file. in this case, it uses the file the script echoes to when using the interactive mode instead of loading data.
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
fi

# end script
