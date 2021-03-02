# bash-scripts
repository of my bash scripts.

currently includes **10** scripts.

* **sync.sh** - updates an arch linux or arch based system and downloads some basic tools that i use
  * *sync_documented.sh* - a variation of sync with comments.
* **install_neofetch.sh** - a script to install the required xcode tools for homebrew, homebrew itself, and neofetch for a macos machine. includes comments.

* **secure_backup.sh** - a bash script that creates an archive of a user's target backup directory, encrypts it, and then sends it over the internet.

* **simple_ssh.sh** - a script to make connecting via OpenSSH just a bit more friendly. can be installed as a system binary.
  *  *simple_ssh_documented.sh* - same thing as above, but with comments.
* **apt_update.sh** - because updating apt-based systems is shit.

* **arrow.sh** - an interactive arch installation script. despite the repo name, runs zsh.

# malware

* **toptenmostdangerouslinuxcommands** - literally deletes root. this is the shittiest thing ever.

* **why** - i wrote this at 1am

*the dev branch is used when working on projects. it contains the most recent versions of my scripts, but they either haven't been fully tested (or tested at all) or are broken.  this is to make sure master doesn't get overwritten, as it typically has the most recent working versions of all of my scripts*

*the previous branch contains the previous versions of every script. this is to make sure bugs that are missed during testing and the merge from dev to master can be reversed easily.*
