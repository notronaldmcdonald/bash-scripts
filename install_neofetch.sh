#!/bin/zsh
# Developed by Brett. (https://www.github.com/notronaldmcdonald)
# For personal use. If you have this script, you aren't allowed to redistribute it without asking.

# the line above is called a 'shebang'. the shebang essentially defines what interpreter/shell the script runs with.
# in this case, the script runs with zsh, as it is the default macos interpreter, and is required to download some of apple's devtools.
# all of the lines beginning with the pound symbol (or hashtags as the hip and cool kids call them) are comments.
# these lines are ignored by the interpreter, and are useful to explain exactly what a script is doing.
xcode-select --install
# xcode is apple's suite of developer tools. it is a dependency for homebrew.
# a dependency, as the name implies, is a piece of software that is required for another software to run.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# to my knowledge, this fetches the homebrew install script from its host location (in this case github).
# once you run the script, it will explain what it does. based on reputation, you can trust the install script.
# if you're paranoid, you can always read what the script is doing before you allow it to do so.
# if i wrote this correctly (i use bash day-to-day, so it is quite possible i didn't), homebrew should now be installed.
# this means that you can now install packages as you please. these are availale on the homebrew website, https://brew.sh/
brew install neofetch
# this line is simple. it uses homebrew to install neofetch. this will probably ask you for confirmation.
# it may also need to install some dependencies. don't worry about that.
# everything in a package manager's repo is checked by the maintainers for malware, and those deps come from the same repo as neofetch.
# once you've read the comments, you can run the command 'chmod +x <script>'. replace <script> with the filename including the extension.
# once you've run that, the script can now be executed. this is typically achieved by typing ./<script> in the terminal.
# if the script has the executable perms, you can also simply double click it in the folder you have it in.
brew --version
# this line will simply report the version of homebrew running. if it reports an output, then it works.
echo Done.
# General Troubleshooting
# to open the terminal, search for it using the macos search function.
# if the commands for granting executable perms or running the script aren't working, make sure you have the filename correct.
# if it still isn't working, make sure your terminal is open in the same folder you have the script in. (put it in your home folder for ease of use)
# if you don't care enough to move it to your home folder, you can use the 'cd' (change directory) command to navigate through your folders.
# if something breaks and you're certain you did everything else right, tell me what errors it throws out and i'll see if i can fix it.
