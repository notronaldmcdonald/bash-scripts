#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias mneofetch='neofetch --config /home/brett/Documents/config.conf'
alias i3lock='i3lock -i /home/brett/pictures2/him.png'
alias cd..='cd ..'
alias startnew='./.new_script.sh'
RED="$(tput setaf 1)"
PURPLE="$(tput setaf 5)"
ORANGE="$(tput setaf 208)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"
USE_TTY_FETCH () { alias neofetch='neofetch --config /home/brett/.config/neofetch/config_tty.conf'; }
ssh-defaults () { ssh -p <port> brett@10.0.0.246; }

if [ "$TERM" = "linux" ]; then

USE_TTY_FETCH
PS1='${GREEN}\A \h/\u \w${RESET}>${BLUE} $ ${RESET}'

elif [[ -n $SSH_CLIENT ]]; then

USE_TTY_FETCH
PS1='${GREEN}\A \u@\h \W${RESET}>${BLUE} $ ${RESET}'
alias exit='echo Goodbye! Have a good day! && exit > /dev/null'

else

PS1='${RED}[${PURPLE}\u${RED}@${PURPLE}\h \W${RED}]\$${ORANGE} '

fi
