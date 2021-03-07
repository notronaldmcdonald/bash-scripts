#!/usr/bin/env bash
# A simple script that exists solely for the purpose of improving my workflow.
# Creates a new script from a skeleton.
# Developed by Brett. (https://github.com/notronaldmcdonald)

# begin script

echo "$(tput sgr0)Welcome. What shell are you making this new script for?"
read -p "Enter your answer: " shell
echo "#!/usr/bin/env $shell" > ~/bash-scripts/newproject.sh
echo "What's a short, one-line description of your script?"
read oneliner
echo "# $oneliner" >> ~/bash-scripts/newproject.sh
read -p "Include author details? (YES/no) " authoryn
if [ "$authoryn" != "no" ]; then
  echo "# Developed by Brett. (https://github.com/notronaldmcdonald)" >> ~/bash-scripts/newproject.sh
else
  echo "nothing" > /dev/null
fi
echo " " >> ~/bash-scripts/newproject.sh
echo "# load foundation variables" >> ~/bash-scripts/newproject.sh
echo " " >> ~/bash-scripts/newproject.sh
echo "source ~/bash-scripts/foundation/foundation-base"
echo " " >> ~/bash-scripts/newproject.sh
echo "# begin script" >> ~/bash-scripts/newproject.sh
echo "What will you name this project?"
read -p "Enter a name: " scriptname
mv ~/bash-scripts/newproject.sh ~/bash-scripts/$scriptname.sh
echo "Done."
