#!/bin/bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# For personal use. If you have this script, you aren't allowed to redistribute it without asking.

# begin script

echo This script will install the set of utilities that you use, and update the system.
read -n1 -r -p "Press any key to start, or CTRL+C to stop execution."
pacman -Syu --noconfirm
echo System update complete.
read -n1 -r -p "If you wish to stop at just updating the system, press CTRL+C. Otherwise, press any key."
echo Will this installation require a GUI?
echo Type YES if yes. Anything else is no.
read input1
if [ "input1" = "YES" ]; then
  pacman -S --noconfirm sudo nano neofetch xorg-server
else
  pacman -S --noconfirm sudo nano neofetch
fi
if [ "input1" = "YES" ]; then
  echo Basic tools installed. Set up the sudoers file, create a user account, and sign out of root.
  echo Afterwards, you can install your desktop environment of choice with ${BLUE}sudo pacman -S <desktop_environment>${RESET}
  echo Have fun with your new Arch Linux system!
else
  echo Basic tools installed. Set up the sudoers file, create a user account, and sign out of root.
  echo Have fun with your new Arch Linux system!
fi

# end script
