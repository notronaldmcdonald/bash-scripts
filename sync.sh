#!/bin/bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# For personal use. If you have this script, you aren't allowed to redistribute it without asking.

# some variables

BLUE=$(tput setaf 6)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)

# begin script

echo "${RED}Note that this script is intended to be run after you've successfully finished the install."
echo "Don't run the script until after you've done everything listed in the installation guide.${RESET}"
read -n1 -r -p "${BLUE}Press any key to start...${RESET}"
echo "This script updates the system (in case an older installation media is used), and downloads and installs some basic tools via pacman."
read -n1 -r -p "Press any key to start, or CTRL+C to stop execution."
pacman -Syu --noconfirm
echo ${GREEN}System update complete.${RESET}
read -n1 -r -p "If you wish to stop at just updating the system, press CTRL+C. Otherwise, press any key."
echo Will this installation require a GUI?
echo ${BLUE}Type YES if yes. Anything else is no.${RESET}
read input1
if [ "input1" = "YES" ]; then
  pacman -S --noconfirm sudo nano neofetch xorg-server
  echo ${GREEN}Basic tools installed.${RESET}
  echo Set up the sudoers file, create a user account, install a desktop environment and sign out of root.
  echo Have fun with your new Arch Linux system!
else
  pacman -S --noconfirm sudo nano neofetch
  echo ${GREEN}Basic tools installed.${RESET}
  echo Set up the sudoers file, create a user account, and sign out of root.
  echo Have fun with your new Arch Linux system!
fi

# end script
