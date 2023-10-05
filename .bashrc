#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias schlaf='systemctl suspend'
#ETH Faecher
alias eprog='cd ~/Documents/ETH/EProg/rrussmann'
alias dismat='cd ~/Documents/ETH/DisMat/'
alias linalg='cd ~/Documents/ETH/LinAlg/'
alias aud='cd ~/Documents/ETH/AUD/'

PS1='\[\e[1;32m\]\u\[\e[m\][\w]\[\e[1;32m\]> \[\e[m\]'
#PS1='[\u@\h \W]$'
