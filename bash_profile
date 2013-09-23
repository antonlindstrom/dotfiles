export PS1="\[\033[G\]\u@\h:\e[0;34m\W\$\e[m "

export CLICOLOR=1

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$PATH:/sbin:/usr/sbin
export GOPATH=~/Documents/Development

# .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Set aliases in separate file
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
