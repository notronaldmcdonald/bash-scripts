# bash-scripts
repository of my bash scripts, and home to Foundation.

currently includes **13** scripts.

* **sync.sh** - updates an arch linux or arch based system and downloads some basic tools that i use. (redundant)
  * *sync_documented.sh* - a variation of sync with comments.
* **install_neofetch.sh** - a script to install the required xcode tools for homebrew, homebrew itself, and neofetch for a macos machine. includes comments.

* **secure_backup.sh** - a bash script that creates an archive of a user's target backup directory, encrypts it, and then sends it over the internet.

* **simple_ssh.sh** - a script to make connecting via OpenSSH just a bit more friendly. can be installed as a system binary. incudes an automatic update function.
  *  *simple_ssh_documented.sh* - same thing as above, but with comments.
* **apt_update.sh** - because updating apt-based systems is shit.

* **csync.sh** - gets dotfiles and moves them to the home directory. (redundant)

* **archsync.sh** - creates base dotfiles for bash + zsh, downloads a few packages. makes *sync* and *csync* redundant.

* **newscript.sh** - creates a basic skeleton for a script. not immediately portable, will require modification.

* **cpuinfo.sh** - get cpu information

# malware

* **toptenmostdangerouslinuxcommands** - literally deletes root. this is the shittiest thing ever.

* **why** - i wrote this at 1am

### What's the deal with the branches?

----------------------------------------------------------------------------------------------
| Branch   | Function                                                                        |
|----------|---------------------------------------------------------------------------------|
| master   | The main branch. Generally stable and fully working.                            |
| dev      | The 'active' branch. Contains active projects, possibly not tested.             |
