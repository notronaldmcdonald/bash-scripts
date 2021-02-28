#!/usr/bin/env bash
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# For personal use. If you have this script, you aren't allowed to redistribute it without asking.

# some variables

BLUE=$(tput setaf 6) # this variable sets any text following it to blue.
RESET=$(tput sgr0) # this variable removes any formatting applied previously INCLUDING anything set forth in .bashrc
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)

# begin script

echo "${RED}Note that this script is intended to be run after you've successfully finished the install."
echo "Don't run the script until after you've done everything listed in the installation guide.${RESET}"
read -n1 -r -p "${BLUE}Press any key to start...${RESET}"
echo "This script updates the system (in case an older installation media is used), and downloads and installs some basic tools via pacman."
# echo simply echoes the text following it to a new line in the command prompt. this is useful for making interactive scripts.
read -n1 -r -p "Press any key to start, or CTRL+C to stop execution."
# this command acts like DOS-PAUSE, which stops the script from processing further commands until user input is delivered. CTRL + C is an escape sequence.
# escape sequences stop the current process in a shell. in this case, it would stop the script from running.
pacman -Syu --noconfirm
# pacman is the arch linux package manager. if you've used something like homebrew on a mac or scoop on windows, you'll recognize that phrase.
# pacman is a little different from something like apt or brew, as you can see by the way it takes arguments.
# the 'S' argument is 'sync'. This downloads and installs the following package. In this case, that doesn't happen.
# the 'y' argument downloads fresh packages from the server the repo is being hosted on. (called a mirror, you'll learn about this later.)
# the 'u' argument is 'upgrade'. this updates every package on the system including the 'base', 'linux', and 'linux-firmware' packages.
# the 'noconfirm' argument means that you don't have to press y to download/install a package.
echo System update complete.
read -n1 -r -p "If you wish to stop at just updating the system, press CTRL+C. Otherwise, press any key."
echo Will this installation require a GUI?
echo ${BLUE}Type YES if yes. Anything else is no.${RESET}
read input1
# this is the more common variation of read used in a script. whatever the end user inputs, it becomes the definition or value of variable 'input1'.
# this can be used to create much more interactive scripts, and scripts that can be used dynamically by any user.
# in this case, since the user entered YES when we asked if they needed a GUI, pacman will install the basic tools and the X display server, which is required for a GUI.
if [ "input1" = "YES" ]; then
  # this is the beginning of a IF statement. this is a type of logical statement. as you can probably see, if the variable from earlier equals to YES, then something happens.
  pacman -S --noconfirm sudo nano neofetch xorg-server
else
  # this portion of the statement is what will happen if the value of input1 is anything BUT 'YES'. this runs the same pacman command, but doesn't install X.
  pacman -S --noconfirm sudo nano neofetch
  # this installs the 'sudo' package (which means you don't have to log in to the root account.), 'nano' (a commandline text editor), and neofetch.
fi
# marks the end of the statement.
if [ "input1" = "YES" ]; then
  echo ${GREEN}Basic tools installed.${RESET}
  echo Set up the sudoers file, create a user account, install a desktop environment and sign out of root.
  echo Have fun with your new Arch Linux system!
else
  echo ${GREEN}Basic tools installed.${RESET}
  echo Set up the sudoers file, create a user account, and sign out of root.
  echo Have fun with your new Arch Linux system!
fi

# end script
