export CLICOLOR=1

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export GOPATH=~/Documents/Development
export PATH=$PATH:/sbin:/usr/sbin
export PATH=/usr/src/go/bin:$PATH:$GOPATH/bin

# .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
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

export PS1="\u@\h:\[$(tput sgr0)\]\[\033[0;32m\]\W:\j\\$\[$(tput sgr0)\]\[\033[0;32m\] \[$(tput sgr0)\]"
