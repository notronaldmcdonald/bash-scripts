#!/bin/bash
# Developed by Brett. (https://github.com/notronaldmcdonald/)
# Leave this heading intact if you choose to share the script!

# This script backs up a directory of your choice (anywhere from '/' to a single file.)
# It places the files in an archive. It then uses GnuPG to encrypt the archive.
# Finally, it sends the file to a target destination using rsync. This can be either to another local machine, or over the internet.
# Sending over the internet requires you to have properly configured port forwarding and SSH on the target machine.
# Backups are saved to your home folder. You can modify the target using the ARCHIVE_TARGET_DIRECTORY variable below.

# some variables

BOLD=$(tput bold)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)

# begin script

echo ${RESET}"Welcome to Brett's Secure Backup Tool!"
echo To begin, enter the ${BOLD}complete path${RESET} of the file/folder you want to backup.
read backup_directory
echo You wish to back up $backup_directory?
echo Type YES or NO.
read answer
if [ "$answer" != "${answer#[YESyes]}" ]; then

  echo Target backup files set.

  elif [ "$answer" != "${answer#[NOno]}" ]; then

    echo Backup script cancelled. && exit

else

  echo Unexpected input received! Exiting. && exit

fi
echo "Now, enter the target machine's IP address."
read target_ip
echo Target IP set.
echo Now, enter the user account you want to use at the target machine.
read target_user
echo Target account set.
echo Finally, enter the port you use for SSH.
read target_ssh_port
echo In order to improve security, public key authentication is used. Please enter your public GnuPG key.
echo "If you don't have a public key, don't input anything. This will instead use less secure symmetric encryption."
echo "Alternatively, you're able to input the email address associated with your public key."
read public_key
echo "Alright! That's just about everything. When you're ready, just enter any key below."
read -n1 -r -p "Input anything to confirm, or use CTRL+C to abort."
echo .
echo "Okay! I'm going to start doing my job now! Your computer may become less responsive during this process."

# begin backup process

echo ${GREEN}Starting backup...
tar -cf $HOME/backup.tar $backup_directory
echo Archive created. Encrypting archive...
if [ "$public_key" != "" ]; then

  echo Using asymmetric encryption...
  gpg -e -r $public_key -o $HOME/backup.tar.gpg $HOME/backup.tar
else

echo Using symmetric encryption. You may receive a password prompt.
gpg -c -o $HOME/backup.tar.gpg $HOME/backup.tar

fi
echo Encryption finished.
rm $HOME/backup.tar
rsync -q --rsh="ssh -p $target_ssh_port" $HOME/backup.tar.gpg $target_user@$target_ip:/home/$target_user/backup.tar.gpg
echo "Okay! I've finished my job. If all went well, your archive should be at the target."

# end of script
