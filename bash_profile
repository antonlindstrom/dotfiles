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

export PS1="\u@\h:\e[0;32m\W:\j$\e[m "
