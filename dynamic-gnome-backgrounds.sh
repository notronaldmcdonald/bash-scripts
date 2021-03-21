#!/usr/bin/env bash
# A script that updates your GNOME background every twelve hours.
# Developed by Brett. (https://github.com/notronaldmcdonald)
# Non-portable.

# some variables

wallpapers=/home/brett/.wallpapers

# begin script

while :; do
  cp $wallpapers/active.png $wallpapers/subout.png
  mv $wallpapers/subin.png $wallpapers/active.png
  mv $wallpapers/subout.png $wallpapers/subin.png
  gsettings set org.gnome.desktop.background picture-uri file://$wallpapers/active.png
  sleep 12h
done

# end script
