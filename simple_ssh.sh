#!/bin/bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# Leave this heading intact if you choose to share the script!

# some variables

RESET=$(tput sgr0)
if [ -e .vars ]; then
  source .vars
fi

# begin script

echo ${RESET}Welcome to SimpleSSH! This script is designed to make using OpenSSH slightly more user friendly.
echo "Use last session settings? Type YES if yes, or NO for no. (This'll error out if you haven't run the script before.)"
read answer
if [ "$answer" != "${answer#[YESyes]}" ]; then

  ssh -p $target_port_persistent $target_user_persistent@$target_ip_persistent

elif [ "$answer" != "${answer#[NOno]}" ]; then

    echo "Okay! Input the user account you're trying to log into remotely."
    read target_user && echo "export target_user_persistent=$target_user" > .vars
    echo "Next, input the IP (local if on LAN) address of the computer you're trying to reach!"
    read target_ip && echo "export target_ip_persistent=$target_ip" >> .vars
    echo "Finally, input the port the SSH daemon is running on. (Hint: by default, it's 22, so if you haven't changed it, then enter 22.)"
    read target_port && echo "export target_port_persistent=$target_port" >> .vars
    ssh -p $target_port $target_user@$target_ip

else

  echo Unexpected input received!

fi

# end script
