#
# ~/.bashrc
#

# .bash_profile
if [ -f ~/.bash_profile ]; then
  . ~/.bash_profile
fi

# Set aliases in separate file
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

COMPLETION_DIR="__nodir__"

if [ -d $COMPLETION_DIR ]; then
  . $COMPLETION_DIR/ghq-completion.bash
  . $COMPLETION_DIR/hub.bash_completion.sh
fi

# Darwin specifics.
uname -a | grep Darwin > /dev/null
if [ $? == 0 ]; then
  # Requires "brew install bash-completion".
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export PS1="\u@\h:\[$(tput sgr0)\]\[\033[0;32m\]\W:\j\\$\[$(tput sgr0)\]\[\033[0;32m\] \[$(tput sgr0)\]"
