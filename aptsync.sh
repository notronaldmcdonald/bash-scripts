#!/bin/bash

echo This script will install the set of utilities that you use, and update the system.
read -n1 -r -p "Press any key to start, or CTRL+C to stop execution."
apt-get upgrade
echo System update complete.
read -n1 -r -p "If you wish to stop at just updating the system, press CTRL+C. Otherwise, press any key."
apt-get install nano neofetch
echo Basic tools installed. Set up the sudoers file, create a user account, and sign out of root. 
