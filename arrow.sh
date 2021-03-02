#!/usr/bin/env zsh
# Developed by Brett. (https://github.com/notronaldmcdonald)
# Interactive Arch Install Script.
# Leave this heading intact if you choose to share the script.

# some variables

BLUE=$(tput setaf 6)
RESET=$(tput sgr0)

# begin script

echo "${RESET}Welcome to ${BLUE}arrow.sh.${RESET}"
echo "This is an interactive Arch Linux installation script."
echo "Ready to begin [Y/n]?"
read ans1
if [ "$ans1" = "n" ] || [ "$ans1" = "N" ]; then
  echo Okay. Exiting...
  exit
else
  echo "Alright! Let's install Arch Linux."
  echo "A couple of things to note: This script can't set up wireless internet for you. It requires a wired connection."
  echo "Checking for boot mode..."
  sleep 1
  ls /sys/firmware/efi/efivars > /dev/null || bios=true
  if [ "$bios" = "true" ]; then
    echo "Booted in BIOS mode."
  else
    echo "Booted in UEFI mode."
  fi
  timedatectl set-ntp true
  echo "Since the next part requires user input, it can't be automated."
  sleep 1
  echo "Don't worry though! Its not that hard."
  fdisk -l
  echo "Identify your target boot drive's block device from this list."
  echo "A block device is an identifier for your disks and partitions."
  echo "It will be something along the lines of /dev/sda. Find the capacity of your intended drive and then find its block device name."
  echo "Once you've done that, type in the full name here (i.e. /dev/sda). Do NOT include any partition numbers."
  read blkdev
  if [ "$bios" = "true" ]; then
    echo "Since you're booted in BIOS mode, follow the Arch Linux Installation Guide's 'Partitioning disks' segment."
    echo "Use the section for 'BIOS with MBR'."
  else
    echo "You're booted in UEFI mode. If you need help partitioning, follow the Arch Linux Installation Guide."
    echo "Specifically, jump to 'Partitioning disks'. Read from the section with 'UEFI with GPT'."
  fi
  sleep 1
  echo "This script assumes you don't need swapspace. You can make one yourself if you see fit, but you'll have to initialize it yourself."
  sleep 1
  fdisk $blkdev
  echo "Now that you're finished, I'll format the partitions."
  echo "To do this without ruining your setup, I'll need the partition numbers of each different partition."
  echo "Make sure to give ONLY the partition numbers."
  echo "Enter partition number for root partition."
  read x
  if [ "$bios" != "true" ]; then
    echo "Now, enter partition number for UEFI system partition."
    read y
  else
    echo "Not booted in UEFI, skipping."
  fi
  echo "Okay! Creating filesystems..."
  mkfs.ext4 $blkdev$x
  mkfs.fat -F32 $blkdev$y
  echo "Filesystems created!"
  sleep 1
  echo "Now, I'll mount the root partition (and EFI if applicable.)"
  mkdir /mnt/efi
  mount $blkdev$x /mnt
  if [ "$bios" != "true" ]; then
    mount $blkdev$y
  else
    echo "Not booted in UEFI, skipping..."
  fi
  sleep 1
  echo "Now installing Linux (via pacstrap)."
  pacstrap /mnt base base-devel linux linux-firmware nano man-db dhcpcd networkmanager zsh sudo xorg-server
  echo "Done!"
  echo "Generating fstab..."
  genfstab -U /mnt >> /mnt/etc/fstab
  echo "Finally, chrooting into your new system."
  arch-chroot /mnt
  zsh
  echo "Now, let's do some setup."
  echo "What country are you from? (case sensitive)"
  read country
  echo "What time zone are you in? (i.e. Eastern, NOT something like EST.)"
  read region
  ln -sf /usr/share/zoneinfo/$country/$region /etc/localtime
  hwclock --systohc
  echo "Now, you need to select your locales. To do so, remove the pound symbol before the ones you want. (i.e. en_US.UTF-8)"
  echo "Ready?"
  read response
  nano /etc/locale.gen
  echo "Good!"
  locale-gen
  echo "Next, set your default language. Use one of the locales you just took."
  sleep 1
  echo "LANG=" > /etc/locale.conf
  nano /etc/locale.conf
  echo "Setting up networking..."
  echo "archlinux" > /etc/hostname
  echo "127.0.0.1 localhost" >> /etc/hosts
  echo "::1 localhost" >> /etc/hosts
  echo "127.0.1.1 archlinux.localdomain archlinux" >> /etc/hosts
  sleep 1
  echo "Set a password for the superuser account."
  passwd
  echo "This final part is up to you. Refer to the 'Boot loader' section of the Installation Guide. Then pick and install a boot loader."
  echo "YOUR COMPUTER WILL NOT BOOT WITHOUT ONE."
  sleep 1
  echo "The installation script is complete. If all was done properly, you should have a fully functioning Arch Linux system."
  echo "Install your bootloader, create a user account, and switch to it. If you so choose, you may also install a desktop environment and/or display manager."
fi
