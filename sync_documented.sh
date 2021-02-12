#!/bin/bash

echo This script will install the set of utilities that you use, and update the system.
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
pacman -S --noconfirm sudo nano neofetch
# this installs the 'sudo' package (which means you don't have to log in to the root account.), 'nano' (a commandline text editor), and neofetch.
echo Basic tools installed. Set up the sudoers file, create a user account, and sign out of root. 
