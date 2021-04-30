#!/usr/bin/env bash
# Developed by Brett. (https://github.com/notronaldmcdonald)
# A pacman-based system synchronization script. Downloads packages, creates new basic dotfiles, and downloads scripts all in one go.

# dotfile function

make_dotfiles () {
  echo "Starting process..."
  touch ~/.bash_profile
  touch ~/.bashrc
  touch ~/.zshrc
  touch ~/.zprofile
  echo "Files made. Writing basic components..."
  echo "bash_profile..."
  echo "source ~/.bashrc" >> ~/.bash_profile
  echo "echo "Welcome, $USER!"" >> ~/.bash_profile
  echo "Done."
  echo "bashrc..."
  echo "PS1='[\u@\h $(tput setaf 6)in$(tput sgr0) \W]\$ '" >> ~/.bashrc
  echo "Done."
  echo "zshrc..."
  echo "PS1='%n@%m %F{6}in%F{15} %1~ %F{1}%# '" >> ~/.zshrc
  echo "source ~/.zsh-extensions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
  echo "source ~/.zsh-extensions/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
  echo "Done."
  echo "zprofile..."
  echo "source ~/.zshrc" >> .zprofile
  echo "echo "Welcome, $USER!"" >> .zprofile
  echo "Finished."
}

# begin script

read -n1 -r -p "Welcome! This script downloads packages, makes new dotfiles, and downloads scripts. Ready to begin? (Press ENTER.)"
echo "Okay! Starting with packages..."
pacman -Syu --noconfirm
read -n1 -r -p "Full system upgrade complete. Press ENTER to continue."
echo "Downloading packages..."
pacman -S --noconfirm sudo nano neofetch xorg-server zsh bpytop
echo "Packages downloaded. Downloading zsh extensions..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-extensions/zsh-syntax-highlighting/
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh-extensions/zsh-autosuggestions/
echo "Downloaded extensions."
read -n1 -r -p "Package + zsh extension downloads finished. Press ENTER to continue."
echo "Creating basic dotfiles..."
make_dotfiles
echo "Dotfiles made. All finished! Basic software, zsh + extensions, and basic dotfiles have been set up."
# end script
